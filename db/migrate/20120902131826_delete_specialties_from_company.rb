class DeleteSpecialtiesFromCompany < ActiveRecord::Migration
  def up
    remove_column :companies, :specialties
  end

  def down
    add_column :companies, :specialties, :string
  end
end
