class Comment < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:50}
  
  attachment :image
  
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
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
  
  
  def self.sort_for(sort)
    if sort == "new"
      self.all.order(created_at: :desc)
    elsif sort == "old"
      self.all.order(created_at: :asc)
    elsif sort == "favorites"
      self.includes(:favorited_users).sort{|a, b| b.favorited_users.size <=> a.favorited_users.size}
    elsif sort == "disfavorites"
      self.includes(:favorited_users).sort{|a, b| a.favorited_users.size <=> b.favorited_users.size}
    else
      self.all.order(created_at: :desc)
    end
  end
  
end
