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

ActiveRecord::Schema.define(version: 20160507061015) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "crypted_password",  limit: 255
    t.string   "email",             limit: 255
    t.integer  "comments_count",    limit: 4,   default: 0, null: false
    t.string   "logo",              limit: 255
    t.string   "openid",            limit: 255
    t.string   "profile_image_url", limit: 255
    t.string   "provider",          limit: 20
    t.string   "profile_url",       limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "file",       limit: 255
    t.integer  "account_id", limit: 4
    t.integer  "blog_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "blog_comments", force: :cascade do |t|
    t.integer  "account_id", limit: 4
    t.integer  "blog_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "blog_contents", force: :cascade do |t|
    t.text     "content",    limit: 16777215, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title",           limit: 255,             null: false
    t.integer  "view_count",      limit: 4,   default: 0, null: false
    t.integer  "blog_content_id", limit: 4
    t.integer  "account_id",      limit: 4
    t.string   "cached_tag_list", limit: 255
    t.integer  "comments_count",  limit: 4,   default: 0, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", unique: true, using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", unique: true, using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", unique: true, using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", unique: true, using: :btree
  add_index "taggings", ["tagger_type"], name: "index_taggings_on_tagger_type", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
