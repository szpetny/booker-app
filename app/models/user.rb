class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  
  before_create :create_remember_token
  
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :surname, length: {maximum: 50}
  validates :email, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  
  def name_and_surname
    "#{@name} #{@surname}"
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
