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

ActiveRecord::Schema.define(version: 20150325162417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "announcements", force: :cascade do |t|
    t.text     "message"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret"
  end

  create_table "campaigns", force: :cascade do |t|
    t.boolean  "status"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "private",        default: false
    t.hstore   "criteria",       default: {}
    t.boolean  "allow_interest", default: false
    t.integer  "language"
    t.string   "image"
    t.string   "organizer"
    t.string   "banner"
    t.boolean  "featured"
  end

  create_table "default_images", force: :cascade do |t|
    t.string   "storage"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_post_id"
    t.string   "message"
    t.integer  "topic_id"
    t.string   "image"
    t.string   "type",             null: false
    t.integer  "campaign_id"
    t.integer  "score"
  end

  create_table "social_scores", force: :cascade do |t|
    t.integer  "facebook_followers", default: 0
    t.integer  "twitter_followers",  default: 0
    t.integer  "total_followers",    default: 0
    t.integer  "user_id"
    t.integer  "viral_score",        default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "taggings", force: :cascade do |t|
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

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "title"
    t.integer  "num_of_shares"
  end

  create_table "user_images", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "storage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                  null: false
    t.string   "crypted_password",                                       null: false
    t.string   "salt",                                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                            default: ""
    t.date     "birthday",                        default: '1970-01-01'
    t.integer  "gender"
    t.integer  "race"
    t.string   "religion"
    t.string   "contact_number"
    t.string   "location"
    t.string   "country"
    t.string   "marital_status"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "role",                            default: 0
    t.string   "image"
    t.integer  "failed_logins_count",             default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.string   "blog_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
