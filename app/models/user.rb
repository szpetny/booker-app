class User < ActiveRecord::Base
   attr_accessor :name, :surname, :email

  def initialize(attributes = {})
    @name  = attributes[:name]
    @surname = attributes[:surname]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} #{@surname} <#{@email}>"
  end
  
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
end
