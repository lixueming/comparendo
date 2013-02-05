class City < ActiveRecord::Base
  belongs_to  :region
  has_many    :companies

  attr_accessible :name, :region
  accepts_nested_attributes_for :region

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :region_id

  def self.autocomplete(field, query_pattern)
    cities = City.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    cities.map { |item| "#{item.send(field)} (city)" }
  end
end
