class Comment < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  attachment :image
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    Favorite.where(user_id: user.id).exists?
  end
end
