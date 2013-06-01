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

ActiveRecord::Schema.define(:version => 20130601084607) do

  create_table "favorite_properties", :force => true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "favorite_properties", ["property_id"], :name => "index_favorite_properties_on_property_id"
  add_index "favorite_properties", ["user_id"], :name => "index_favorite_properties_on_user_id"

  create_table "images", :force => true do |t|
    t.string   "attachment"
    t.integer  "property_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "attachment_processing"
  end

  add_index "images", ["property_id"], :name => "index_images_on_property_id"

  create_table "properties", :force => true do |t|
    t.string   "status"
    t.integer  "price"
    t.integer  "floor_size"
    t.integer  "year"
    t.string   "street"
    t.integer  "street_number"
    t.boolean  "moderation",    :default => false
    t.string   "contact_info"
    t.text     "summary"
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "bathroom"
    t.integer  "bedroom"
    t.integer  "parking"
    t.string   "category"
    t.string   "city"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
