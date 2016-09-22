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

ActiveRecord::Schema.define(version: 20160915054631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fulfillments", force: :cascade do |t|
    t.integer  "fulfiller_id"
    t.integer  "wanter_id"
    t.integer  "wanted_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["fulfiller_id"], name: "index_fulfillments_on_fulfiller_id", using: :btree
    t.index ["wanted_id"], name: "index_fulfillments_on_wanted_id", using: :btree
    t.index ["wanter_id"], name: "index_fulfillments_on_wanter_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "password_identities", force: :cascade do |t|
    t.integer "user_id",         null: false
    t.string  "password_digest", null: false
    t.index ["user_id"], name: "index_password_identities_on_user_id", using: :btree
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.index ["user_id"], name: "index_proposals_on_user_id", using: :btree
  end

  create_table "requisitions", force: :cascade do |t|
    t.integer  "requester_id"
    t.integer  "offerer_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["offer_id"], name: "index_requisitions_on_offer_id", using: :btree
    t.index ["offerer_id"], name: "index_requisitions_on_offerer_id", using: :btree
    t.index ["requester_id"], name: "index_requisitions_on_requester_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "active"
    t.integer  "frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secure_key"
    t.string   "type"
    t.datetime "last_sent"
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "facebook_url"
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.text     "about"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_url"
    t.string   "ea_profile"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_foreign_key "password_identities", "users"
end
