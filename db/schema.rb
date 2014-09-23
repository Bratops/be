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

ActiveRecord::Schema.define(version: 20140923085458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "edu_holders", force: true do |t|
    t.string  "name"
    t.integer "schools_count"
    t.integer "users_count"
    t.integer "ugroups_count"
  end

  create_table "edu_levels", force: true do |t|
    t.string  "name"
    t.integer "schools_count"
    t.integer "users_count"
    t.integer "ugroups_count"
  end

  create_table "edu_locs", force: true do |t|
    t.string  "name"
    t.integer "schools_count", null: false
    t.integer "users_count"
    t.integer "ugroups_count"
  end

  create_table "edu_schools", force: true do |t|
    t.string   "name"
    t.string   "moeid"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "loc_id"
    t.integer  "level_id"
    t.integer  "holder_id"
    t.integer  "users_count"
    t.integer  "ugroups_count"
  end

  add_index "edu_schools", ["holder_id"], name: "index_edu_schools_on_holder_id", using: :btree
  add_index "edu_schools", ["level_id"], name: "index_edu_schools_on_level_id", using: :btree
  add_index "edu_schools", ["loc_id"], name: "index_edu_schools_on_loc_id", using: :btree

  create_table "edu_ugroups", force: true do |t|
    t.integer  "school_id"
    t.string   "name"
    t.integer  "enrollments_count"
    t.integer  "users_count"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.datetime "exdate"
    t.integer  "extime"
    t.integer  "grade"
    t.integer  "klass"
    t.string   "note"
    t.string   "gcode"
  end

  add_index "edu_ugroups", ["school_id"], name: "index_edu_ugroups_on_school_id", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer  "user_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "ugroup_id"
    t.integer  "gender"
    t.string   "name"
    t.integer  "seat"
    t.string   "suid"
    t.string   "status"
  end

  add_index "enrollments", ["ugroup_id"], name: "index_enrollments_on_ugroup_id", using: :btree
  add_index "enrollments", ["user_id"], name: "index_enrollments_on_user_id", using: :btree

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
    t.string   "info_link"
    t.string   "tube"
  end

  add_index "menus", ["lft"], name: "index_menus_on_lft", using: :btree
  add_index "menus", ["parent_id"], name: "index_menus_on_parent_id", using: :btree
  add_index "menus", ["rgt"], name: "index_menus_on_rgt", using: :btree

  create_table "msgs", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree
  add_index "roles", ["resource_id"], name: "index_roles_on_resource_id", using: :btree
  add_index "roles", ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "task_choices", force: true do |t|
    t.text    "content"
    t.integer "index"
    t.integer "task_choice_id"
    t.boolean "answer"
  end

  add_index "task_choices", ["task_choice_id"], name: "index_task_choices_on_task_choice_id", using: :btree

  create_table "task_infos", force: true do |t|
    t.string   "title"
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
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "task_infos", ["cached_votes_down"], name: "index_task_infos_on_cached_votes_down", using: :btree
  add_index "task_infos", ["cached_votes_score"], name: "index_task_infos_on_cached_votes_score", using: :btree
  add_index "task_infos", ["cached_votes_total"], name: "index_task_infos_on_cached_votes_total", using: :btree
  add_index "task_infos", ["cached_votes_up"], name: "index_task_infos_on_cached_votes_up", using: :btree
  add_index "task_infos", ["cached_weighted_average"], name: "index_task_infos_on_cached_weighted_average", using: :btree
  add_index "task_infos", ["cached_weighted_score"], name: "index_task_infos_on_cached_weighted_score", using: :btree
  add_index "task_infos", ["cached_weighted_total"], name: "index_task_infos_on_cached_weighted_total", using: :btree
  add_index "task_infos", ["tid"], name: "index_task_infos_on_tid", using: :btree

  create_table "user_infos", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "gender"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "user_id"
    t.datetime "birth"
  end

  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id", using: :btree

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
    t.integer  "current_group_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["current_group_id"], name: "index_users_on_current_group_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login_alias"], name: "index_users_on_login_alias", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["suid"], name: "index_users_on_suid", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree
  add_index "users", ["xrole_id"], name: "index_users_on_xrole_id", using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["role_id"], name: "index_users_roles_on_role_id", using: :btree
  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  add_index "users_roles", ["user_id"], name: "index_users_roles_on_user_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
