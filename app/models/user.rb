class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :name, presence: true, length:{in:1..10}

  attachment :profile_image

  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_comments, through: :favorites, source: :comment

  has_many :post_comments, dependent: :destroy

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


  def follow(user_id)
    self.follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    self.follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    self.following_user.include?(user)
  end



  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forword'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backword'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  # フォロー通知
  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id=? and visited_id=? and action=?", current_user.id, id, 'follow'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
        )

      notification.save if notification.valid?
    end
  end

end
