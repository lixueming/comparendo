class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
  attr_accessible :rating, :content, :user

  validates_presence_of :rating
  validates_presence_of :content

  scope :latest, lambda { order('created_at DESC') }
end
