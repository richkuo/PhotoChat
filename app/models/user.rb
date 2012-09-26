class User < ActiveRecord::Base
  attr_accessible :name, :last_name, :email, :password, :password_confirmation
  has_secure_password

  # User behaviors
  has_many :microposts, dependent: :destroy

  has_many :relationships, foreign_key: "follower_id",
                           dependent: :destroy
   
  has_many :reverse_invitations, foreign_key: "uploader_id",
                                 class_name: "Invitation",
                                 dependent: :destroy
   
  has_many :followed_users, through: :relationships, source: :followed
   
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy

  has_many :followers, through: :reverse_relationships, source: :follower

  # Events, Pictures, Commenting
  has_many :events_attended, through: :reverse_invitations, source: :event
 
  has_many :events_hosted, foreign_key: "host_id", class_name: "Event"

  has_many :pictures

  has_many :comments, foreign_key: "user_id", class_name: "Comment"

  # New Users
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 45 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 45 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
   
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def following_host?
    relationships.find_by_followed_id(1)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def feed
    Micropost.from_users_followed_by(self)
  end

private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
