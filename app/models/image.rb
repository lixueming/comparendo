class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  belongs_to :user

  image_accessor :image
  attr_accessible :image, :image_name, :user_id
  
  include Rails.application.routes.url_helpers  

  #one convenient method to pass jq_upload the necessary information
  def to_jq_upload(size = '200x140')
    if errors.empty?
      {
        :name => read_attribute(:image_name),
        :size => image.size,
        :url => image.url,
        :thumbnail_url => image.thumb(size).url,
        :delete_url => image_path(:id => id),
        :delete_type => "DELETE"
      }
    else
      {
        :name => read_attribute(:image_name),
        :size => image_size,
        :error => errors.full_messages[0]
      }
    end
  end
end
 