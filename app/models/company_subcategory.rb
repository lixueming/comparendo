class CompanySubcategory < ActiveRecord::Base
	belongs_to :subcategory
	belongs_to :company

	validates_presence_of :subcategory, :company

  attr_accessible :subcategory, :company
end
