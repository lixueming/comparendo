class Region < ActiveRecord::Base
  belongs_to  :country
  has_many    :cities
  has_many    :companies

  attr_accessible :id, :name, :country
  accepts_nested_attributes_for :country

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :country_id
  scope :of_name, ->(name) {
    where(name: name)
  }

  def self.autocomplete(field, query_pattern)
    regions = Region.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    regions.map { |item| "#{item.send(field)} (region)" }
  end
end
