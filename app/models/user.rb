class User < ActiveRecord::Base
  include Sluggable
  
  has_many :posts
  has_many :comments
  has_many :votes
  has_many :user_permissions
  has_many :permissions, through: :user_permissions

  has_secure_password

  validates :username, presence: true, uniqueness:true
  validates :password, length: {minimum: 6}, on: :create
  validates_confirmation_of :password, on: :create

  sluggable_column :username

end