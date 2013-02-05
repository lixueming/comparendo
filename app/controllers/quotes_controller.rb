# encoding: utf-8
class QuotesController < ApplicationController
	before_filter :check_params, only: [:new]
  add_breadcrumb "Offerte anfordern", '/offerte-anfordern'

  def new
    add_breadcrumb "Geben Sie nun bitte einige zusätzliche Informationen zu Ihrem Projekt an", nil
  	@project = Project.new
  end

  def create
  	@project = Project.new params[:project]
  	if @project.save
      unless params[:options].blank?
        params[:options].values.each do |opt|
          @project.options << Answer.create(opt[:answer])
        end
        @project.save
      end
  		flash[:notice] = "Project was created successfully"
  		render :show
  	else
  		flash[:error] = "Project not created, #{@project.error.full_messages.join(',')}"
  		render :new
  	end
  end

  def show
  	@project = Project.find params[:id]
  end

  private
    def check_params
      redirect_to new_offer_path and return if params[:subcategory_id].blank?

      @subcategory = Subcategory.find params[:subcategory_id]
      redirect_to new_offer_path and return if @subcategory.nil?

      @category = @subcategory.category
      @region = Region.find_by_id(params[:region_id]) unless params[:region_id].blank?
    end
end
