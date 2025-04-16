class Group < ApplicationRecord
    belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

    has_many :memberships, dependent: :destroy
    has_many :contributions, dependent: :destroy
    has_many :users, through: :memberships
    has_many :transactions, dependent: :destroy
    has_many :histories, dependent: :destroy


    validates :name, presence: true
    validates :join_code, presence: true, uniqueness: true
  end  