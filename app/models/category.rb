class Category < ActiveRecord::Base
  has_many :subcategories

  attr_accessible :description, :icon, :name

  validates_presence_of :name
  validates_uniqueness_of :name
  
  
  def self.autocomplete(field, query_pattern)
    categories = Category.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    categories.map { |item| "#{item.send(field)}"}
  end
end
