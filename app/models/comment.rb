class Comment < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:50}
  
  attachment :image
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(user)
    self.favorites.where(user_id: user.id).exists?
  end
  
  
  
  def self.search_for(content, method)
    if method == 'perfect'
      Comment.where(title: content)
    elsif method == 'forword'
      Comment.where('title LIKE ?', content + '%')
    elsif method == 'backword'
      Comment.where('title LIKE ?', '%' + content)
    else
      Comment.where('title LIKE ?', '%' + content + '%')
    end
  end
  
end
