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

ActiveRecord::Schema.define(version: 20150726113450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keyword_sets", force: :cascade do |t|
    t.string   "name"
    t.datetime "analysed_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "status",      limit: 2, default: 0, null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.integer  "keyword_set_id"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "keywords", ["keyword_set_id"], name: "index_keywords_on_keyword_set_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "keyword_id"
    t.string   "url"
    t.string   "domain"
    t.string   "title"
    t.text     "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "results", ["keyword_id"], name: "index_results_on_keyword_id", using: :btree

  add_foreign_key "keywords", "keyword_sets"
  add_foreign_key "results", "keywords"
end
