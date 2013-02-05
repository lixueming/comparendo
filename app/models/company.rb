class Company < ActiveRecord::Base
  PER_PAGE = 10

  belongs_to :city
  belongs_to :region
  belongs_to :user
  
  has_many :images, :as => :imageable
  has_many :reviews, :as => :reviewable
  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  has_many :company_subcategories
  has_many :subcategories, :through => :company_subcategories
  
  has_many :activity_regions
  has_many :regions, :through => :activity_regions
 
  image_accessor :cover_image

  attr_accessible :user, :user_id, :city, :city_id, :region_id, :region, :name, :email,
                  :contact_person, :postal_code, :latitude, :longitude,
                  :description, :long_description, :address, :phone_numbers,
                  :websites, :thumbnail, :cover_image,
                  :draft, :sponsor, :reviews
                  
  accepts_nested_attributes_for :city, :region

  serialize :phone_numbers, JSON
  serialize :websites, JSON

  before_create :generate_uid

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_each :phone_numbers, :allow_nil => true do |record, attr, phone_numbers|
    phone_numbers.each do |phone_number|
      unless phone_number.strip.blank? or phone_number =~ /^[0-9\(\)\- ]+$/
        record.errors.add(attr, 'Invalid phone number format')
      end
    end
  end

  before_save :filter_blank_phone_numbers
  before_save :filter_blank_websites
  before_save :filter_html_tags
  before_save :denormalize_region_and_city

  scope :by_alphabetical, order(:name)
  scope :sponsors,                  where(:sponsor => true)
  scope :of_uid,          ->(uid) { where(:uid => uid)}
  scope :of_region_id,    ->(region) { where(:region_id => region)}
  scope :without_company, ->(company) { where("id <> ?", company.id) }
  scope :of_tag,          ->(tag_name) { joins(:tags).where("tags.name = ?", tag_name.downcase) }
  scope :of_name_like,    ->(name) { where("lower(name) LIKE ?", name.downcase) }
  scope :of_region_name,  ->(region) { where("lower(region_name) LIKE ?", region.downcase) }
  scope :of_city_name,    ->(city) { where("lower(city_name) LIKE ?", city.downcase ) }
  

  def rating
    # slow implementation, to be replaced
    rating = 0
    count = 0
    self.reviews.each do |review|
      rating += review.rating
      count += 1
    end
    if count > 0
      rating = rating / count
    end
    rating
  end

  def generate_uid
    token = rand(36**12).to_s(36)
    while Company.where(:uid => token).size > 0
      token = rand(36**12).to_s(36)
    end
    self.uid = token
  end

  def other_companies_from_region
    companies = Company.without_company(self).of_region_id(region)
    companies.sort! { |x, y| y.rating <=> x.rating }
    max = 5
    companies[0...max]
  end

  def self.autocomplete_clickable(field, query_pattern, &block)
    companies = Company.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    links = companies.map { |item| block.call(item) }
    values = companies.map { |item| "#{item.send(field)}"}
    JqueryAutocomplete.array_of_clickable values, links
  end

  def self.autocomplete(field, query_pattern)
    companies = Company.order(field).where("#{field} LIKE ?", "%#{query_pattern}%")
    companies.map { |item| "#{item.send(field)}"}
  end


  def self.search_by_query(query_hash)
    page_index = query_hash[:page] || 1
    companies = Company.scoped
    if query_hash.present?
       companies = companies.of_name_like query_hash[:name] if query_hash[:name].present?
       companies = companies.of_region_name(query_hash[:region]) if query_hash[:region].present?
       companies = companies.of_city_name(query_hash[:city]) if query_hash[:city].present?
       companies = companies.of_tag(query_hash[:tag]) if query_hash[:tag].present?
    end 
    
    companies.page(page_index).per(Company::PER_PAGE)
  end 

private

  def filter_blank_phone_numbers
    return if self.phone_numbers.blank?
    self.phone_numbers.delete_if {|a| a.strip.blank? }
  end

  def filter_blank_websites
    return if self.websites.blank?
    self.websites.delete_if {|a| a.strip.blank? }
  end

  def filter_html_tags
    self.description = HTMLProcessor::filter_html(self.description) if self.description.present?
    self.long_description = HTMLProcessor::filter_html(self.long_description) if self.long_description.present?
  end

  def denormalize_region_and_city
    self.region_name = self.region.name unless self.region.nil?
    self.city_name = self.city.name  unless self.city.nil?
  end

  
end
