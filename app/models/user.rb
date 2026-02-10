class User < ApplicationRecord
  has_secure_password

  has_many :accounts, dependent: :destroy
  has_one :savings_account, class_name: "SavingsAccount"
  has_one :investing_account, class_name: "InvestingAccount"

  validates :name, presence: true
end
