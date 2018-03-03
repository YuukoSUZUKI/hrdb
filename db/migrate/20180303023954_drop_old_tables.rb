class DropOldTables < ActiveRecord::Migration[5.1]
  def change
   # drop_table:talents
   # drop_table:employees
    drop_table:users
  end
end
