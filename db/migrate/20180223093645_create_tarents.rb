class CreateTarents < ActiveRecord::Migration[5.1]
  def change
    create_table :tarents do |t|
      t.integer :learning_level
      t.references :user, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
