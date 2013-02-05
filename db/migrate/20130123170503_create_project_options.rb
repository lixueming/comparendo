class CreateProjectOptions < ActiveRecord::Migration
  def change
    create_table :project_options do |t|
      t.references :project
      t.references :answer
    end
  end
end
