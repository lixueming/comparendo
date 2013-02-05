class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :budget,          :float
    add_column :projects, :start_date,      :date
    add_column :projects, :end_date,        :date

    add_column :projects, :data,            :text

    add_column :projects, :project_type_id, :integer
  end
end
