class Profile < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :articles
  has_many :members
  has_many :groups, through: :members
  mount_uploader :avatar, AvatarUploader
  has_many :follow_friends,  class_name:  "Friend",
                                   foreign_key: "from_user_id",
                                   dependent:   :destroy
  has_many :follower_friends, class_name:  "Friend",
                                   foreign_key: "to_user_id",
                                   dependent:   :destroy
  has_many :from_users, through: :follower_friends,  source: :from_user
  has_many :to_users, through: :follow_friends, source: :to_user
  validates :nickname,presence: true
  validates :text,presence: true


  def  following?(other_user)
      self.follow_friends.find_by(to_user_id: other_user)
  end

  def follow(other_user)
    self.follow_friends.find_or_create_by(to_user_id: other_user.id)
  end

  def friend?(other_user)
    self.follow_friends.find_by(to_user_id: other_user,request: true)
  end

  def unfollow(other_user)
    self.follow_friends.find_by(to_user_id: other_user.id)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = "password"
      user.confirmed_at = Time.now  
    end
  end

end
