class Admin::CompanyController < Admin::AdminController

  before_filter :load_cities, :only => [:new, :edit, :create, :update]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    respond_to do |format|
      if @company.save
        format.html { redirect_to admin_company_index_url, :notice => 'Company was successfully created.' }
      else
        flash[:error] = @company.errors.values[0][0]
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to admin_company_index_url, :notice => 'Company was successfully updated.' }
      else
        flash[:error] = @company.errors.values[0][0]
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to admin_company_index_url, :notice => 'Company was successfully deleted.' }
    end
  end

  private

    def load_cities
      @cities = City.all
    end

end