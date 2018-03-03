class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.integer :employee_number
      t.string :name
      t.date :birthday
      t.text :speciality
      t.text :memo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
