class Account < ApplicationRecord
  include ActionView::RecordIdentifier
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users
  
  # Temporary: maintains compatibility until user_id column is removed or fully deprecated
  belongs_to :user, optional: true 

  has_many :ledger_entries, dependent: :destroy

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :interest_rate, numericality: { greater_than_or_equal_to: 0 }
  validates :type, uniqueness: { scope: :user_id, message: "already exists for this user" }
  
  # Broadcasts balance updates to the dashboard via Turbo Streams
  after_update_commit -> { 
    broadcast_replace_to "user_#{user_id}_dashboard", 
                         target: dom_id(self, :balance), 
                         partial: "accounts/balance", 
                         locals: { account: self }
  }
  
  after_create :add_owner_to_members
  
  private
  
  def add_owner_to_members
    users << user if user.present? && !users.include?(user)
  end
end
