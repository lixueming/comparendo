class OfferController < ApplicationController
  set_tab :offer
  add_breadcrumb "Offerte anfordern", '/offerte-anfordern'
  before_filter :newest_infos, :only => :new

  def new

    if params[:category_id].nil?
      @categories = Category.all
      @row_in_column = @categories.count / 2
      @categories.each {|cat| @row_in_column += cat.subcategories.count}
      @row_in_column = @row_in_column / 3
      render 'select_category'
    else
      @category = Category.find(params[:category_id])
      unless @category
        @category = Category.new
      #else
      #  flash[:error] = t('offer.notices.project_type_not_found')
      #  redirect_to new_offer_url
      end
    end
  end

  def create
    #unless current_user
    #  session[:project] = params[:project]
    #  session[:user_return_to] = offer_created_url
    #  flash[:error] = t(:you_need_to_login_to_continue)
    #  redirect_to new_user_session_url
    #  return
    #end

    #project = params[:project]
    #
    #project[:start_date] = Date.new(project[:start_date_year].to_i, project[:start_date_month].to_i, 1)
    #project[:end_date] = Date.new(project[:end_date_year].to_i, project[:end_date_month].to_i, 1)
    #project[:data][:land_available] = (project[:data][:land_available] == '1') ? true : false
    #
    #@project = current_user.projects.create(project.except(:start_date_month, :start_date_year, :end_date_month, :end_date_year))
    #if @project
    #  redirect_to offer_created_url
    #else
    #  flash[:error] = @project.errors.full_messages[0]
    #  render :new
    #end
  end

  def created
    #if session[:project].present?
    #  project = session[:project]
    #  session[:project] = nil
    #
    #  project[:start_date] = Date.new(project[:start_date_year].to_i, project[:start_date_month].to_i, 1)
    #  project[:end_date] = Date.new(project[:end_date_year].to_i, project[:end_date_month].to_i, 1)
    #  project[:data][:land_available] = (project[:data][:land_available] == '1') ? true : false
    #
    #  @project = current_user.projects.create(project.except(:start_date_month, :start_date_year, :end_date_month, :end_date_year))
    #  if @project
    #    # render :created
    #  else
    #    flash[:error] = @project.errors.full_messages[0]
    #    render :new
    #  end
    #else
    #  # render :created
    #end
  end

  def show
    # TODO
  end

end
