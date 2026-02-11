class ChangeInterestRatePrecisionInAccounts < ActiveRecord::Migration[7.1]
  def change
    change_column :accounts, :interest_rate, :decimal, precision: 10, scale: 4, default: 0.0, null: false
  end
end
