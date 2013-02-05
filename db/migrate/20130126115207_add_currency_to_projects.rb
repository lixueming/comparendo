class AddCurrencyToProjects < ActiveRecord::Migration
  def change
  	add_column :projects, :currency, :string, limit: 10
  end
end
