class AddTokenExpireToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token_expire, :datetime
  end
end
