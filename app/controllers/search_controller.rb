class SearchController < ApplicationController

	def index
		parse_search_query
	end

	def region_select
		add_breadcrumb "Offerte anfordern", '/offerte-anfordern'
		add_breadcrumb I18n.t(:select_region_title), nil
		
		redirect_to new_offer_path and return if params[:subcategory_id].blank?

    @subcategory = Subcategory.find params[:subcategory_id]
    redirect_to new_offer_path and return if @subcategory.nil?
	end

	private
		def parse_search_query
			subcategory_indx = 0
			region_indx = 1

			query = params[:q].split(',')
			query.map!{|q| q.strip }

			@subcategory = Subcategory.find_by_name(query[subcategory_indx]) if query.size > subcategory_indx
			@region = Region.find_by_name(query[region_indx]) if query.size > region_indx
		end

end
