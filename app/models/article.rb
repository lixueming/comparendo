class Article < ActiveRecord::Base
  THUMB_SIZE = "200x150"
  SIZE_FOR_SHORT = 800

	attr_accessible :author, :title, :body, :tags, :images_attributes
  belongs_to  :author, :class_name => "User", :foreign_key => "author_id"
  
  has_many :images, :as => :imageable
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  validates :author, :presence => true
  validates :title, :presence => true, :length => { :maximum => 150 }


  before_save :set_path
  accepts_nested_attributes_for :images


  def has_cover_image?
    images.any? && !images.last.new_record?
  end

  def short_description
    body.size > SIZE_FOR_SHORT ? "#{body[0..SIZE_FOR_SHORT]}..." : body
  end

  def cover_image
    images.last.image
  end

  def thumb_image
    images.last.image.thumb(THUMB_SIZE)
  end


  def self.autocomplete_clickable(field, query_pattern, &block)
    articles = Article.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    links = articles.map { |item| block.call(item) }
    values = articles.map { |item| "#{item.send(field)}" }
    JqueryAutocomplete.array_of_clickable values, links
  end


  def self.last_five
    Article.order("id desc").limit(5)
  end


private

  def set_path
    require 'code_extensions.rb'
    self.path = CodeExtensions::PARSE_FOR_PATH.(title.strip.downcase)
  end
end