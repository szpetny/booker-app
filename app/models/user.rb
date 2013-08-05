class User < ActiveRecord::Base
  before_save {email.downcase!}
  
  has_secure_password

=begin
  def formatted_user_record
    "#{@name} #{@surname} <#{@email}>"
  end
=end


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :surname, length: {maximum: 50}
  validates :email, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  
end
