class Permission < ActiveRecord::Base
  has_many :user_permissions
  has_many :users, through: :user_permissions

  validates :permissions, presence: true
end