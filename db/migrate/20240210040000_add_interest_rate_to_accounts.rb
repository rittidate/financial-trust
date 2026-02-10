class AddInterestRateToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :interest_rate, :decimal, precision: 5, scale: 4, default: 0.0, null: false
  end
end
