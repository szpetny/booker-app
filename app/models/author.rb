class Author < ActiveRecord::Base
    has_many :books
    
    validates :name, presence: true, length: {maximum: 50}
    validates :surname, presence: true, length: {maximum: 50}
end
