class AddPathColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :path, :string, :limit => 150, :null => false
  end
end
