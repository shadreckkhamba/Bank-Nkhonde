class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :user
end
