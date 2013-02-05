class SubcategoriesController < ApplicationController
  def index
    @subcategories = Subcategory.of_category(params[:category])
  end
end
