class User < ApplicationRecord
  has_secure_password

  has_many :account_users, dependent: :destroy
  has_many :accounts, through: :account_users
  
  # Helpers to find specific account types (returns first match)
  def savings_account
    accounts.where(type: 'SavingsAccount').first
  end

  def investing_account
    accounts.where(type: 'InvestingAccount').first
  end

  validates :name, presence: true
end
