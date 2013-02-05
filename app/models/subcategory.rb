class Subcategory < ActiveRecord::Base
  belongs_to :category
  has_many :questions, dependent: :destroy

  attr_accessible :description, :icon, :name, :category_id

  validates_presence_of :name

  scope :of_name, ->(name) {
    where(name: name)
  }
  scope :of_category, ->(cat) {
    where(category_id: cat)
  }
  
  
  def self.autocomplete(field, query_pattern)
    subcategories = Subcategory.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    subcategories.map { |item| "#{item.send(field)}"}
  end
end
