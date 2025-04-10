class Group < ApplicationRecord
    has_many :memberships
    has_many :users, through: :memberships
    has_many :contributions
    has_many :transactions  # Assuming there's a Transaction model
    has_many :histories     # Assuming there's a History model (if these are the names of your models)
  end  