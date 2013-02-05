class CitiesController < ApplicationController
  def name_autocomplete
    term = params[:term]
    if params[:region_id]
      cities = City.select(:name).where('name LIKE ? AND region_id = ?', "#{term}%", params[:region_id]).
        group(:name).order(:name)
    else
      cities = City.select(:name).where('name LIKE ?', "#{term}%").group(:name).order(:name)
    end
    city_names = cities.map { |city| city.name }

    respond_to do |format|
      format.json { render :json => city_names }
    end
  end
end