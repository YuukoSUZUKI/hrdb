class DropOldTables < ActiveRecord::Migration[5.1]
  def change
    create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer "employee_number"
      t.string "name"
      t.date "birthday"
      t.text "speciality"
      t.text "memo"
      t.bigint "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_employees_on_user_id"
    end
  
    create_table "skill_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string "skill_category_name"
      t.integer "sort_order"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string "skill_name"
      t.boolean "has_learning_level"
      t.bigint "skill_category_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["skill_category_id"], name: "index_skills_on_skill_category_id"
    end
  
    create_table "talents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.integer "learning_level"
      t.bigint "user_id"
      t.bigint "skill_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["skill_id"], name: "index_talents_on_skill_id"
      t.index ["user_id"], name: "index_talents_on_user_id"
    end
  
    create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
      t.string "account"
      t.integer "authority"
      t.string "token"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "password"
      t.index ["token"], name: "index_users_on_token", unique: true
    end
  
    add_foreign_key "employees", "users"
    add_foreign_key "skills", "skill_categories"
    add_foreign_key "talents", "skills"
    add_foreign_key "talents", "users"
  end
end
