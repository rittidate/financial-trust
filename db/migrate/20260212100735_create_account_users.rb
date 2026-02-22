class CreateAccountUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :account_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    add_index :account_users, [:user_id, :account_id], unique: true

    # Backfill data strictly using SQL to avoid model loading issues
    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO account_users (user_id, account_id, created_at, updated_at)
          SELECT user_id, id, NOW(), NOW()
          FROM accounts
        SQL
      end
    end
  end
end
