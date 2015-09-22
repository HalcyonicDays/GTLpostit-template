class Comment < ActiveRecord::Base
  include VoteableGem

  belongs_to :user
  belongs_to :post

  validates :body, presence: true
end