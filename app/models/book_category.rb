class BookCategory < ActiveRecord::Base
    has_and_belongs_to_many :books
    validates :category_name, presence: true
end
