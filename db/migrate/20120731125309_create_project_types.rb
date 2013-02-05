class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|
      t.string :title
      t.string :image_file_name
      t.text :description

      t.timestamps
    end
  end
end
