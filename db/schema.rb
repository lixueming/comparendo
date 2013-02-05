# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130131192507) do

  create_table "answers", :force => true do |t|
    t.text    "description"
    t.integer "question_id"
  end

  create_table "articles", :force => true do |t|
    t.string   "title",      :limit => 150, :null => false
    t.text     "body"
    t.integer  "author_id",                 :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "path",       :limit => 150, :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "icon"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cities", :force => true do |t|
    t.integer  "region_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "companies", :force => true do |t|
    t.integer  "region_id"
    t.integer  "city_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "cover_image_uid"
    t.string   "cover_image_name"
    t.string   "email"
    t.string   "contact_person"
    t.string   "postal_code"
    t.text     "description"
    t.text     "long_description"
    t.text     "address"
    t.text     "phone_numbers"
    t.text     "websites"
    t.string   "thumbnail"
    t.decimal  "latitude",                       :precision => 10, :scale => 6
    t.decimal  "longitude",                      :precision => 10, :scale => 6
    t.string   "region_name"
    t.string   "city_name"
    t.boolean  "draft",                                                         :default => true
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
    t.boolean  "sponsor",                                                       :default => false, :null => false
    t.string   "uid",              :limit => 20,                                                   :null => false
  end

  create_table "company_subcategories", :force => true do |t|
    t.integer "company_id",     :null => false
    t.integer "subcategory_id", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "image_uid"
    t.string   "image_name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "project_options", :force => true do |t|
    t.integer "project_id"
    t.integer "answer_id"
  end

  create_table "project_types", :force => true do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "long_description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.float    "budget"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "data"
    t.integer  "project_type_id"
    t.integer  "user_id"
    t.integer  "region_id"
    t.string   "currency",         :limit => 10
  end

  create_table "questions", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.string  "question_type"
    t.integer "subcategory_id"
  end

  create_table "regions", :force => true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.string   "user_id"
    t.text     "content"
    t.float    "rating"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "subcategories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "icon"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "taggable_id"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "description"
    t.boolean  "admin",                  :default => false
    t.string   "image_uid"
    t.string   "image_name"
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "author",                 :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
