class Contact < ActiveRecord::Base
  attr_accessible :combo, :description, :email, :name , :subject
    CONSTANT= [["test1", "test1"], ["test2","test2"], ["test3","test3"], ["test4","test4"]]
    validates :name, :presence => true
    validates :email, :presence => true
    validates :subject, :presence => true
    validates :description, :presence => true
    

  
end
