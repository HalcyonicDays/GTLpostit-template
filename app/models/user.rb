class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  validates :username, presence: true, uniqueness:true
  validates :password, length: {minimum: 6}, on: :create
  validates_confirmation_of :password, on: :create
end