class Industry < ActiveRecord::Base

  # validations
  validates :name, :presence => true
  
  
end
