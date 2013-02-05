class Project < ActiveRecord::Base
  belongs_to :project_type
  belongs_to :user
  belongs_to :region

  has_many :project_options
  has_many :options, through: :project_options

  accepts_nested_attributes_for :project_options

  attr_accessible :name, :budget, :start_date, :end_date, :data,
                  :user, :description, :long_description,
                  :date, :timeframe, :attachments,
                  :project_type_id, :project_options_attributes,
                  :region_id, :currency

  validates_uniqueness_of :name, :scope => :project_type_id

  serialize :data, JSON
end
