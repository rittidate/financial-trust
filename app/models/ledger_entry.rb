class LedgerEntry < ApplicationRecord
  belongs_to :account

  validates :amount, presence: true
  validates :entry_type, presence: true, inclusion: { in: %w[transfer_in transfer_out] }

  # Optional: Helpful scopes
  scope :credits, -> { where(entry_type: 'transfer_in') }
  scope :debits, -> { where(entry_type: 'transfer_out') }
end
