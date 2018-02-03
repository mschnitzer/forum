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

ActiveRecord::Schema.define(version: 20180203122959) do

  create_table "board_permission_to_targets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "permission_id"
    t.integer "board_id"
    t.integer "group_id"
    t.integer "user_id"
    t.boolean "value", null: false
    t.index ["permission_id", "board_id", "group_id"], name: "index_unique_board_and_group", unique: true
    t.index ["permission_id", "board_id", "user_id"], name: "index_unique_board_and_user", unique: true
  end

  create_table "board_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.boolean "default_value", null: false
  end

  create_table "board_thread_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "thread_id"
    t.integer "user_id"
    t.string "username"
    t.boolean "user_deleted", default: false, null: false
    t.string "title"
    t.text "message", limit: 16777215
    t.boolean "thread_starter", default: false, null: false
    t.boolean "closed", default: false, null: false
    t.boolean "disabled", default: false
    t.boolean "deleted", default: false, null: false
    t.integer "deleted_by_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "board_threads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "board_id"
    t.integer "user_id"
    t.string "username"
    t.boolean "user_deleted", default: false, null: false
    t.boolean "sticky", default: false, null: false
    t.boolean "announcement", default: false, null: false
    t.boolean "closed", default: false, null: false
    t.boolean "disabled", default: false, null: false
    t.boolean "deleted", default: false, null: false
    t.integer "deleted_by_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "parent_id"
    t.string "external_url"
    t.boolean "category", default: false, null: false
    t.integer "position", default: 1, null: false
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "name_format", default: "%s"
    t.boolean "default_group", default: false, null: false
    t.boolean "guest_group", default: false, null: false
  end

  create_table "permission_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "permission_to_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "permission_id"
    t.integer "group_id"
    t.text "value", limit: 16777215
    t.index ["group_id", "permission_id"], name: "index_permission_to_groups_on_group_id_and_permission_id", unique: true
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.integer "category_id"
    t.integer "value_type"
    t.text "default_value", limit: 16777215
  end

  create_table "user_to_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.index ["user_id", "group_id"], name: "index_user_to_groups_on_user_id_and_group_id", unique: true
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
