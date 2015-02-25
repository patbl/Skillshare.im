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

ActiveRecord::Schema.define(version: 20141125045755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fulfillments", force: :cascade do |t|
    t.integer  "fulfiller_id"
    t.integer  "wanter_id"
    t.integer  "wanted_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fulfillments", ["fulfiller_id"], name: "index_fulfillments_on_fulfiller_id", using: :btree
  add_index "fulfillments", ["wanted_id"], name: "index_fulfillments_on_wanted_id", using: :btree
  add_index "fulfillments", ["wanter_id"], name: "index_fulfillments_on_wanter_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",        limit: 255
  end

  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "requisitions", force: :cascade do |t|
    t.integer  "requester_id"
    t.integer  "offerer_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "requisitions", ["offer_id"], name: "index_requisitions_on_offer_id", using: :btree
  add_index "requisitions", ["offerer_id"], name: "index_requisitions_on_offerer_id", using: :btree
  add_index "requisitions", ["requester_id"], name: "index_requisitions_on_requester_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "active"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secure_key", limit: 255
    t.string   "type",       limit: 255
    t.datetime "last_sent"
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 255
    t.string   "facebook_url",     limit: 255
    t.string   "location",         limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.text     "about"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_url",       limit: 255
    t.string   "ea_profile",       limit: 255
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
  end

end
