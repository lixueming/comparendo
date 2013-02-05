class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.belongs_to :from, :class => "User", :foreign_key => "from_id", :null => false
    	t.belongs_to :to, :class => "User", :foreign_key => "to_id", :null => false
    	t.string :subject
      t.text :body

    	
      t.timestamps
    end
  end
end
