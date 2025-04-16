class User < ApplicationRecord
  has_secure_password
  has_many :administered_groups, class_name: 'Group', foreign_key: 'admin_id'

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  belongs_to :group, optional: true
  has_many :contributions, dependent: :destroy
  has_many :transactions
  has_many :histories, dependent: :destroy

  # Validations
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?
  validates :username, presence: true, uniqueness: true

  validates :phone, allow_blank: true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit phone number" }

  # Optional fields
  validates :email, presence: false
  validates :gender, presence: false
  validates :role, presence: false
  validates :group_id, presence: false
  
  # Optional associations
  belongs_to :group, optional: true

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