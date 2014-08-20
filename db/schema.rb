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

ActiveRecord::Schema.define(version: 20140818162537) do

  create_table "stared_repos", force: true do |t|
    t.integer  "user_id"
    t.integer  "remote_id"
    t.integer  "stargazers_count"
    t.string   "name"
    t.string   "full_name"
    t.string   "homepage"
    t.string   "html_url"
    t.string   "ssh_url"
    t.text     "description"
    t.text     "readme_html"
    t.datetime "pushed_at"
    t.datetime "synced_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stared_repos", ["user_id"], name: "index_stared_repos_on_user_id"

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
    t.string   "github_uid"
    t.string   "github_username"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
