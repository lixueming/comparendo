class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :description
      t.string :question_type
      t.references :subcategory
    end
  end
end
