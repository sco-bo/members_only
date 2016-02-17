class User < ActiveRecord::Base
  attr_accessor :token
  has_many :posts

  before_create :remember
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 65}, 
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  #Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.token = User.new_token
    self.remember_token = Digest::SHA1.hexdigest(token) #needs to be adjusted. if users already have remember_token should be changed to update_attribute
  end

  #Returns true if given token matches the digest
  def authenticated?(given_token)
    BCrypt::Password.new(remember_token).is_password?(given_token)
  end

  def forget
    update_attribute(:remember_token, nil)
  end
end
