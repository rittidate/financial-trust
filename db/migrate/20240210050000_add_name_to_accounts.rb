class AddNameToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :name, :string
  end
end
