class AddSponsorToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :sponsor, :boolean, :default => false, :null => false
  end
end
