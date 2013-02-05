class Tag < ActiveRecord::Base
  
  has_many :taggings
  has_many :articles, :through => :taggings, :source => :taggable, :source_type => "Article"
  has_many :companies, :through => :taggings, :source => :taggable, :source_type => "Company"
 

  attr_accessible :name
  #validates_uniqueness_of :name, :if => lambda{ self.name.present? }
  before_save :downcase_name

  def self.autocomplete_clickable(field, query_pattern, &block)
    tags = Tag.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    links = tags.map { |item| block.call(item) }
    values = tags.map { |item| "#{item.send(field)}" }
    JqueryAutocomplete.array_of_clickable values, links
  end


  def self.autocomplete(field, query_pattern)
    tags = Tag.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    tags.map { |item| "#{item.send(field)}" }
  end


private
  def downcase_name
    self.name.downcase!
  end
end
