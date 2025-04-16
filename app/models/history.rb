class History < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :action, presence: true
  validates :timestamp, presence: true
end