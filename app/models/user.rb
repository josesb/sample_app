class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email = email.downcase }
  before_create :create_remember_token # 1 create remember_token before creating user

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # add DAN14 pag 51
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password #add DAN14 pag 66
  validates :password, length: { minimum: 6 } #add DAN14 pag 70

  def User.new_remember_token # 3
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token) # 4
    Digest::SHA1.hexdigest(token.to_s) # SHA1 faster than bcrypt
  end

  def feed
    Micropost.from_users_followed_by(self)
  end


  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  private # hidden from everyone except the User model

  def create_remember_token # 2
    self.remember_token = User.encrypt(User.new_remember_token) # self = the object being created
  end

end

