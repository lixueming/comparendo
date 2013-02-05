class SetupTaggings < ActiveRecord::Migration
  def up
  	rename_column 	:taggings, :taggable, :taggable_type
  	add_column 		:taggings, :taggable_id, :integer
  end

  def down
	rename_column 	:taggings, :taggable_type, :taggable 
	remove_column 	:taggings, :taggable_id, :integer
  end
end
