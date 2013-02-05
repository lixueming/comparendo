class CreateActivityRegions < ActiveRecord::Migration
  def change
    create_table :activity_regions do |t|
    	t.references :company
    	t.references :region
      t.timestamps
    end
  end
end
