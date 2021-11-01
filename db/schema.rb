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

ActiveRecord::Schema.define(version: 2020_06_11_190424) do

  create_table "article_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "picture"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "introduction"
    t.index ["article_id"], name: "index_article_images_on_article_id"
  end

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "introduction"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "lat", precision: 7, scale: 5
    t.decimal "lng", precision: 8, scale: 5
    t.bigint "profile_id"
    t.bigint "group_id"
    t.index ["group_id"], name: "index_articles_on_group_id"
    t.index ["profile_id"], name: "index_articles_on_profile_id"
  end

  create_table "comment_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "picture"
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "introduction"
    t.index ["comment_id"], name: "index_comment_images_on_comment_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "article_id"
    t.bigint "profile_id"
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["profile_id"], name: "index_comments_on_profile_id"
  end

  create_table "friends", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "request", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "from_user_id"
    t.bigint "to_user_id"
    t.index ["from_user_id"], name: "index_friends_on_from_user_id"
    t.index ["to_user_id"], name: "index_friends_on_to_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "text"
    t.bigint "admin_user_id"
    t.index ["admin_user_id"], name: "index_groups_on_admin_user_id"
  end

  create_table "members", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id"
    t.index ["group_id", "profile_id"], name: "index_members_on_group_id_and_profile_id", unique: true
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["profile_id"], name: "index_members_on_profile_id"
  end

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname"
    t.string "avatar"
    t.string "text"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.string "last_name"
    t.string "first_name"
    t.string "last_name_kana"
    t.string "first_name_kana"
    t.string "cell_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "article_images", "articles"
  add_foreign_key "articles", "groups"
  add_foreign_key "articles", "profiles"
  add_foreign_key "comment_images", "comments"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "profiles"
  add_foreign_key "friends", "profiles", column: "from_user_id"
  add_foreign_key "friends", "profiles", column: "to_user_id"
  add_foreign_key "groups", "profiles", column: "admin_user_id"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "profiles"
  add_foreign_key "profiles", "users"
end
