class Message < ActiveRecord::Base
	belongs_to :sender, :foreign_key => "from_id", :class_name => "User"
	belongs_to :recipient, :foreign_key => "to_id", :class_name => "User"
  has_many :attachments

  attr_accessible :subject, :body, :from, :recipient, :project, :previousmessage
  
  validates_presence_of :subject, :sender, :recipient

end