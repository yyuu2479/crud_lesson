class Comment < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  attachment :image
  
  belongs_to :user
end
