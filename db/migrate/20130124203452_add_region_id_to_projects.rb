class AddRegionIdToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :region_id, :integer
  end
end
