class CreateFinancialTrustTables < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type, null: false, index: true
      t.decimal :balance, precision: 15, scale: 2, default: 0.0, null: false
      t.timestamps
    end

    create_table :ledger_entries do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :entry_type, null: false
      t.timestamps
    end
  end
end
