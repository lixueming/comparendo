class Tagging < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true

  attr_accessible :tag_id, :taggable_type, :taggable_id

  scope :of_tag, ->(tag) {
  	where(tag_id: tag)
  }

  scope :of_taggable, ->(taggable) {
    where(taggable_type: taggable.class.to_s).where(taggable_id: taggable.id)
  }
end
