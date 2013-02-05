class CreateCompanies < ActiveRecord::Migration
  def change
    # architect has images, reviews, description, email, address, phone_numbers, websites, location, specialties,
    # additional info, and thumbnail
    create_table :companies do |t|
      t.references  :region
      t.references  :city
      t.references  :user
      t.string      :name
      t.string      :cover_image_uid
      t.string      :cover_image_name
      t.string      :email
      t.string      :contact_person
      t.string      :postal_code
      t.text        :description
      t.text        :long_description
      t.text        :address
      t.text        :phone_numbers
      t.text        :websites
      t.string      :thumbnail
      t.decimal     :latitude,  :precision => 10, :scale => 6
      t.decimal     :longitude, :precision => 10, :scale => 6
      t.text        :specialties
      t.string      :region_name
      t.string      :city_name
      t.boolean     :draft, :default => true

      t.timestamps
    end
  end
end
