class Comment < ApplicationRecord
  require 'active_support/all'
  
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:50}

  attachment :image
  is_impressionable counter_cache: true

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :post_comments, dependent: :destroy
  
  has_many :notifications, dependent: :destroy


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
      self.order(created_at: :desc)
    elsif sort == "old"
      self.order(created_at: :asc)
    elsif sort == "favorites"
      self.includes(:favorited_users).sort{|a, b| b.favorited_users.size <=> a.favorited_users.size}
    elsif sort == "disfavorites"
      self.includes(:favorited_users).sort{|a, b| a.favorited_users.size <=> b.favorited_users.size}
    elsif sort == "impressionist"
      self.order(impressions_count: :desc)
    elsif sort == "disimpressionist"
      self.order(impressions_count: :asc)
    else
      self.order(created_at: :desc)
    end
  end


  # いいね通知
  def create_notification_like(current_user)
    temp = Notification.where(["visitor_id=? and visited_id=? and comment_id=? and action=?", current_user.id, user_id, id, 'favorite'])
    
    if temp.blank?
      notification = current_user.active_notifications.new(
        comment_id: id, 
        visited_id: user_id, 
        action: 'favorite'
      )
      
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      
      notification.save if notification.valid?
    end
  end


  # コメント通知
  def create_notification_comment(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(comment_id: id).where.not(user_id: current_user.id).distinct
    
    temp_ids.each do |temp_id| 
      save_notification_comment(current_user, post_comment_id, temp_id['user_id'])
    end
    
    save_notification_comment(current_user, post_comment_id, user_id) if temp_ids.blank?
  end
  
  
  def save_notification_comment(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      comment_id: id,
      post_comment_id: post_comment_id, 
      visited_id: visited_id, 
      action: 'post_comment'
    )
    
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    
    notification.save if notification.valid?
  end
  
end
