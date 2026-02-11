class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :status, default: "pending", null: false

      t.timestamps
    end
  end
end
