class RegionsController < ApplicationController
  def name_autocomplete
    term = params[:term]
    regions = Region.select(:name).where('name LIKE ?', "#{term}%").group(:name).order(:name)
    region_names = regions.map { |region| region.name }

    respond_to do |format|
      format.json { render :json => region_names }
    end
  end
end