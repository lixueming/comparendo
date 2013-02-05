class ActivityRegion < ActiveRecord::Base
	belongs_to :region
	belongs_to :company

	validates_presence_of :region, :company
  # attr_accessible :title, :body
end
