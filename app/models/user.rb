class User < ApplicationRecord
    has_secure_password
    has_many :memberships, dependent: :destroy
    has_many :groups, through: :memberships
    belongs_to :group
    has_many :contributions
    has_many :transactions  
    has_many :histories    
  
    # Validations
    validates :password, presence: true, length: { minimum: 6 }, confirmation: true
    validates :password_confirmation, presence: true
    
    # Additional validation to ensure users are correctly assigned to groups
    validates :group_id, presence: true
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, allow_blank: true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit phone number" }
    validates :gender, inclusion: { in: ['male', 'female', 'other'], message: "%{value} is not a valid gender" }
    validates :role, inclusion: { in: ['admin', 'member'], message: "%{value} is not a valid role" }
  
    # Methods to check user roles
    def admin?
      role == 'admin'
    end
  
    def member?
      role == 'member'
    end
  end
  