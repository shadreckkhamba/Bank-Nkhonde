class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  belongs_to :group
  has_many :contributions, dependent: :destroy
  has_many :transactions
  has_many :histories, dependent: :destroy

  # Validations
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  validates :group_id, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, allow_blank: true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit phone number" }
  validates :gender, inclusion: { in: ['male', 'female', 'other'], message: "%{value} is not a valid gender" }
  validates :role, inclusion: { in: ['admin', 'member'], message: "%{value} is not a valid role" }

  private

  def password_required?
    new_record? || !password.nil?
  end

  def admin?
    role == 'admin'
  end

  def member?
    role == 'member'
  end
end