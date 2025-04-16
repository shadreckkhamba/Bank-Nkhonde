class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :status, inclusion: { in: ['active', 'inactive', 'left'], message: "%{value} is not a valid status" }
  scope :active_members, ->(group_id) { where(group_id: group_id, status: 'active') }

  validates :user_id, presence: true
  validates :group_id, presence: true
  
  def admin?
      role == 'admin'
  end
end
