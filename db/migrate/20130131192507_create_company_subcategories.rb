class CreateCompanySubcategories < ActiveRecord::Migration
  def change
    create_table :company_subcategories do |t|
    	t.belongs_to :company, :null => false
    	t.belongs_to :subcategory, :null => false
    end
  end
end
