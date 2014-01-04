class Author < ActiveRecord::Base
    has_many :books, :dependent => :restrict_with_exception
    
    validates :name, presence: true, length: {maximum: 50}
    validates :surname, presence: true, length: {maximum: 50}
    
    def name_and_surname
      "#{name} #{surname}"
    end
    
    def surname_and_name
      "#{surname} #{name}"
    end
end
