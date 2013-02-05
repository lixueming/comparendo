class CompanyController < ApplicationController
  
  set_tab :company, :only => %w(eintragen eintragen1 eintragen2 eintragen3 eintragen4)
  set_tab :home, :only => %w(index show edit update)
  
  before_filter :newest_infos, :only => [:index, :eintragen]
  before_filter :load_cities, :only => [:edit, :update]
  before_filter :authenticate_user!, :except=>[:index, :show, :eintragen]

  load_and_authorize_resource
  add_breadcrumb I18n.t('architect'), :architekten_path
  

  def index
    add_breadcrumb I18n.t('architect'), "#{url_for(:only_path => true)}/?#{request.query_string}"
    @companies = Company.search_by_query(params)
    @title = search_page_titles
    append_page_title @title
    append_meta_tags_search_page
  end



  def show
    if params[:id].present?
      @company = Company.find_by_id(params[:id])

    elsif params[:region].present? and params[:uid] and params[:company].present?
      @company = Company.find_by_uid(params[:uid])

    elsif params[:region].present? and params[:city].present? and params[:company].present?
      #will always throw an exception! Must be fixed or route must be removed
      @company = Company.where("name like ?","%#{params[:company]}%")

    else
      render_404
    end

    unless @company
      render_404
      return
    end

    add_breadcrumb_to_show_page
  end


  def edit
    @company = Company.find(params[:id])
    @regions = switzerland_regions
  end


  def update
    @company = Company.find(params[:id])

    # get city
    @city = City.where("lower(name) = ? AND region_id = ?", params[:company][:city].downcase,
                       params[:company][:region_id]).first
    if @city.nil?
      @region = Region.find(params[:company][:region_id])
      @city = @region.cities.create(:name => params[:company][:city])
    end
    params[:company][:city_id] = @city.id

    respond_to do |format|
      if @company.update_attributes(params[:company].except(:city))
        format.html { redirect_to company_url(@company), :notice => 'Company was successfully updated.' }
        format.json { render :json => {:success => true} }
      else
        format.html {
          flash[:error] = @company.errors.values[0][0]
          render :action => "edit"
        }
        format.json { render :json => {:success => false, :message => @company.errors.values[0][0]} }
      end
    end
  end

  def update_cover_image
    authorize! :update, Company
    authorize! :create, Image

    @company = Company.find(params[:id])
    size = params[:size] || '200x140'
    if @company.update_attributes(params[:company])
      render :json => {
        :success => true,
        :image => {
          :name => @company.cover_image_name,
          :url => @company.cover_image.thumb(size).url,
          :delete_url => image_url(@company.cover_image)
        }
      }
    else
      render :json => {:success => false, :message => @company.errors.values[0][0]}
    end
  end


  def eintragen
    if request.get?
      find_or_restore_company_step1
      
      if user_signed_in? && current_user.has_company?
        flash[:error] = "User cannot have multiple Companies" # TODO fix message and move to de.yml
        render "warning"
      end
    elsif request.post?
      add_company_step1

      unless user_signed_in?
        redirect_to new_user_session_url
        return
      end
    end

    @regions =  switzerland_regions
    add_breadcrumb "Firma eintragen", "firma-eintragen"
  end
  
  def eintragen2
    @company = Company.find(params[:id])
    authorize! :update, @company

    if params[:company]
      # get city
      @city = City.where("lower(name) = ? AND region_id = ?", params[:company][:city].downcase, params[:company][:region_id]).first
      if @city.nil?
        @region = Region.find_by_id(params[:company][:region_id])
        @city = @region.cities.create(:name => params[:company][:city]) if @region
      end
      params[:company][:city_id] = @city.id if @city

      if @company.update_attributes(params[:company].except(:city))
        redirect_to company_add3_url(:id => @company.id)
      else
        flash[:error] = @company.errors.values[0][0]
      end
    end

	  add_breadcrumb "Firma eintragen  - #{t('general.step')} 2", "firma-eintragen/schritt-2"
  end
  
  def eintragen3
    @company = Company.find(params[:id])
    authorize! :update, @company

    if params[:company]
      specialties = prepare_specialties(params[:company].delete(:specialties))
      subcategories = prepare_subcategories params[:company].delete(:subcategories)

      if @company.update_attributes(params[:company])
        @company.tags << specialties
        @company.subcategories << subcategories
        @company.save
        redirect_to company_add4_url(:id => @company.id)
      else
        flash[:error] = @company.errors.values[0][0]
      end
    end

	  add_breadcrumb "Firma eintragen  - #{t('general.step')} 3", "firma-eintragen/schritt-3"
  end

  def eintragen4
	  add_breadcrumb "Firma eintragen  - #{t('general.step')} 4", "firma-eintragen/schritt-4"
  end

  private

################ adding company - step 1 ##################################

  def find_or_restore_company_step1
    @company =  if params[:id].present?
                  Company.find(params[:id])
                else
                  Company.new(temp_company)
                end
  end

  def add_company_step1
    unless user_signed_in?
      save_temp_data_to_login
      return
    end

    temp_company_clear
    @company =  params[:id].present? ? Company.find(params[:id]) : Company.new
    company_params = params[:company]
    company_params[:user_id] = current_user.id
    if @company.update_attributes(company_params)
      redirect_to company_add2_url(:id => @company.id)
    else
      flash[:error] = @company.errors.values[0][0]
    end
  end

  def save_temp_data_to_login
      self.temp_company = params[:company]
      session[:user_return_to] = request.url
      flash[:error] = t(:you_need_to_login_to_continue)
  end

  def temp_company
    session[:company] if session[:company].present?
  end

  def temp_company=(value)
    session[:company] = value
  end

  def temp_company_clear
    session[:company] = nil
  end

################ adding company - step 1 end ##################################




  def load_cities
      @cities = City.all
  end



  def add_breadcrumb_to_show_page
    add_breadcrumb_by_region_and_city @company.region_name, @company.city_name
    add_breadcrumb @company.name, nil
  end

  def add_breadcrumb_by_region_and_city(region_name=nil, city_name=nil)
    if region_name.nil? and city_name.nil?
      raise ArgumentError 'region_name and city_name are nil!'
    end

    search_options = {:utf8 => "%E2%9C%93", :q=>"architekten"}
    if region_name
      search_options[:region] = region_name
      add_breadcrumb "Architekten #{region_name}",generate_search_query(search_options)
    end

    if city_name
      search_options[:city] = city_name
      add_breadcrumb "Architekten #{city_name}",generate_search_query(search_options)
    end
  end


  def generate_search_query(search_options)
    "/company?#{CGI.unescape(search_options.to_query)}"
  end

  def switzerland_regions
    Country.find_by_name('Switzerland').regions
  end


  def search_page_titles
    title = I18n.t('company.index.title')
    tag = params[:tag]
    city = params[:city]
    region = params[:region]

    if tag.present?  or city.present? or region.present?

      if city.present?
        title << " #{city}"
        title << ", " if region.present?
      end

      title << " #{region}" if region.present?
      title << " - #{tag}" if tag.present?
    else
      title << " #{I18n.t('switzerland')}"
    end

    title
  end

  def append_meta_tags_search_page
    append_meta_keywords_search_page
    append_meta_tag_description "A description of Company -> Architekten search page"
  end

  def append_meta_keywords_search_page
    fields = params.values_at(:tag, :city, :region).select(&:present?)
    append_meta_tag_keywords(fields.join(", ").concat(".")) unless fields.empty?
  end

  def prepare_specialties str_specialties
    current_specialties = @company.tags
    new_specialties = []
    for_destroy = []
    for_create = []

    unless str_specialties.blank?
      str_specialties.split(",").uniq.each do |name|
        new_specialties << Tag.find_or_create_by_name(name: name)
      end
      new_specialties.uniq! unless new_specialties.empty?
    end

    for_destroy = current_specialties - new_specialties
    for_create = new_specialties - current_specialties

    for_destroy.each do |s|
      scp = Tagging.of_tag(s)
      scp = scp.of_taggable(@company)
      scp.destroy_all
    end
    for_create
  end

  def prepare_subcategories str_subcategories
    current_subcategories = @company.subcategories
    new_subcategories = []
    for_destroy = []
    for_create = []
    unless str_subcategories.blank?
      str_subcategories.split(",").uniq.each do |name|
        new_subcategories << Subcategory.find_by_name(name)
      end
      unless new_subcategories.empty?
        new_subcategories.uniq!
        new_subcategories.compact!
      end
    end
    for_destroy = current_subcategories - new_subcategories
    for_create = new_subcategories - current_subcategories

    for_destroy.each do |s|
      scp = CompanySubcategory.where(subcategory_id: s)
      scp = scp.where(company_id: @company)
      scp.destroy_all
    end
    for_create
  end
end
