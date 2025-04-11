class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
end
