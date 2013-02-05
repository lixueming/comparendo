class RemoveTagsFromArticle < ActiveRecord::Migration
  def up
  	remove_column :articles, :tags
  end

  def down
  	add_column :articles, :tags, :text
  end
end
