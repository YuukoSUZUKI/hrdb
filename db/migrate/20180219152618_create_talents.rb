class CreateTalents < ActiveRecord::Migration[5.1]
  def change
    create_table :talents do |t|
      t.string :name
      t.date :birth
      t.text :speciality
      t.text :memo

      t.timestamps
    end
  end
end
