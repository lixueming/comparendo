class AddUidToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :uid, :string, :limit => 20, :null => false
    Company.all.each{|c| c.generate_uid }
  end
end
