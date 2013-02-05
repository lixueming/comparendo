class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.string :description
      t.string :icon
      t.references :category

      t.timestamps
    end
    add_index :subcategories, :category_id
  end
end
