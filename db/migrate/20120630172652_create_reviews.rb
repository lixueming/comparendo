class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string      :user_id
      t.text        :content
      t.float       :rating
      t.references  :reviewable, :polymorphic => true

      t.timestamps
    end
  end
end
