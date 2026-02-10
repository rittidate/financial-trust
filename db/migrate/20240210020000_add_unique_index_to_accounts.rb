class AddUniqueIndexToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_index :accounts, [:user_id, :type], unique: true
  end
end
