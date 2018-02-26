class CreateSkillCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :skill_categories do |t|
      t.string :skill_category_name
      t.integer :sort_order

      t.timestamps
    end
  end
end
