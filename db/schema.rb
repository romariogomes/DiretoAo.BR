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

ActiveRecord::Schema.define(version: 20170609181344) do

  create_table "acceptances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "interaction_id"
    t.index ["interaction_id"], name: "index_acceptances_on_interaction_id"
  end

  create_table "charges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "charge_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "description"
    t.integer "comment_father"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "interaction_id"
    t.index ["interaction_id"], name: "index_comments_on_interaction_id"
  end

  create_table "experiences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "init_year"
    t.integer "end_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "politician_id"
    t.index ["politician_id"], name: "index_experiences_on_politician_id"
  end

  create_table "interactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "law_project_id"
    t.string "notice_references"
    t.index ["law_project_id"], name: "index_interactions_on_law_project_id"
    t.index ["user_id"], name: "index_interactions_on_user_id"
  end

  create_table "law_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "law_number"
    t.text "description"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "politician_id"
    t.index ["politician_id"], name: "index_notices_on_politician_id"
  end

  create_table "politician_laws", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "politician_id"
    t.bigint "law_project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["law_project_id"], name: "index_politician_laws_on_law_project_id"
    t.index ["politician_id"], name: "index_politician_laws_on_politician_id"
  end

  create_table "politicians", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.date "birthdate"
    t.string "party"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "charge_id"
    t.bigint "state_id"
    t.index ["charge_id"], name: "index_politicians_on_charge_id"
    t.index ["state_id"], name: "index_politicians_on_state_id"
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "state_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "acceptances", "interactions"
  add_foreign_key "comments", "interactions"
  add_foreign_key "experiences", "politicians"
  add_foreign_key "interactions", "law_projects"
  add_foreign_key "interactions", "users"
  add_foreign_key "notices", "politicians"
  add_foreign_key "politician_laws", "law_projects"
  add_foreign_key "politician_laws", "politicians"
  add_foreign_key "politicians", "charges"
  add_foreign_key "politicians", "states"
end
