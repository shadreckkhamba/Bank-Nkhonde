class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :status, inclusion: { in: %w[pending completed failed], message: "%{value} is not a valid status" }
end