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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140905140218) do

  create_table "age_levels", force: true do |t|
    t.string  "name"
    t.integer "schools_count"
    t.integer "users_count"
    t.integer "ugroups_count"
  end

  create_table "enrollments", force: true do |t|
    t.integer  "user_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "ugroup_id"
  end

  add_index "enrollments", ["ugroup_id"], name: "index_enrollments_on_ugroup_id"
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id"

  create_table "holders", force: true do |t|
    t.string  "name"
    t.integer "schools_count"
    t.integer "users_count"
    t.integer "ugroups_count"
  end

  create_table "locations", force: true do |t|
    t.string  "name"
    t.integer "schools_count", null: false
    t.integer "users_count"
    t.integer "ugroups_count"
  end

  create_table "menus", force: true do |t|
    t.integer  "parent_id"
    t.string   "klass"
    t.string   "name"
    t.string   "desc"
    t.string   "icon"
    t.string   "link"
    t.integer  "pos"
    t.integer  "children_count"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "menus", ["lft"], name: "index_menus_on_lft"
  add_index "menus", ["parent_id"], name: "index_menus_on_parent_id"
  add_index "menus", ["rgt"], name: "index_menus_on_rgt"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"
  add_index "roles", ["resource_id"], name: "index_roles_on_resource_id"
  add_index "roles", ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"

  create_table "schools", force: true do |t|
    t.string   "name"
    t.string   "moeid"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "location_id"
    t.integer  "age_level_id"
    t.integer  "holder_id"
    t.integer  "users_count"
    t.integer  "ugroups_count"
  end

  add_index "schools", ["age_level_id"], name: "index_schools_on_age_level_id"
  add_index "schools", ["holder_id"], name: "index_schools_on_holder_id"
  add_index "schools", ["location_id"], name: "index_schools_on_location_id"

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.text     "body"
    t.text     "quest"
    t.text     "explain"
    t.text     "info"
    t.text     "link"
    t.string   "region"
    t.string   "tid"
    t.integer  "old_id"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "ugroups", force: true do |t|
    t.integer  "school_id"
    t.string   "name"
    t.integer  "group_type"
    t.integer  "enrollments_count"
    t.integer  "users_count"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "ugroups", ["school_id"], name: "index_ugroups_on_school_id"

  create_table "user_infos", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "gender"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "user_id"
  end

  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.string   "login_alias"
    t.string   "suid"
    t.string   "provider"
    t.string   "uid"
    t.string   "xrole_id"
    t.integer  "roles_count"
    t.integer  "enrollments_count"
    t.integer  "ugroups_count"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["login_alias"], name: "index_users_on_login_alias"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["suid"], name: "index_users_on_suid"
  add_index "users", ["uid"], name: "index_users_on_uid"
  add_index "users", ["xrole_id"], name: "index_users_on_xrole_id"

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["role_id"], name: "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  add_index "users_roles", ["user_id"], name: "index_users_roles_on_user_id"

end
