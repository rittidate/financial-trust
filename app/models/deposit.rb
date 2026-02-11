class Deposit < ApplicationRecord
  belongs_to :account
  has_one_attached :slip

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected] }

  enum status: { pending: "pending", approved: "approved", rejected: "rejected" }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= "pending"
  end
end
