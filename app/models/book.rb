class Book < ActiveRecord::Base
  belongs_to :author

  validates :isbn, presence: true, format: /[\-0-9]+/
  validates :title, presence: true
  validates :quantity, numericality: true
  validates :pages, numericality: true
  validates :place, presence: true
end
