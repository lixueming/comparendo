class Country < ActiveRecord::Base
  has_many :regions

  attr_accessible :name

  validates_presence_of :name
  validates_uniqueness_of :name
end
