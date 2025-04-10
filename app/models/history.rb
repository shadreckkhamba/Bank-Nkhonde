class History < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :action, presence: true
  validates :timestamp, presence: true
end