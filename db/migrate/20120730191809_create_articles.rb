class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string		  :title, :limit => 150, :null => false
      t.text        :body
      t.belongs_to  :author, :class => "User", 
      				:foreign_key => "author_id", 
      				:null => false

      t.timestamps
    end
  end
end
