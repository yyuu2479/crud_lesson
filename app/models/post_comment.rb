class PostComment < ApplicationRecord
  validates :post_comment, presence: true, length:{maximum:50}  
  
  belongs_to :user
  belongs_to :comment
  
  has_many :notifications, dependent: :destroy
  
end
