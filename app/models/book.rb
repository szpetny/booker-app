class Book < ActiveRecord::Base
  belongs_to :author 
  has_and_belongs_to_many :book_categories
  validates :author_id, presence: true
  validates :isbn, presence: true, format: /[\-0-9]+/
  validates :title, presence: true
  validates :quantity, numericality: {greater_than: 0}, :unless => Proc.new {|book| book.quantity.nil? }
  validates :pages, numericality: {greater_than: 0}, :unless => Proc.new {|book| book.pages.nil? }
  validates :place, presence: true
  validates :release_date, format: /\A((1[89][0-9]{2}|20[0-9]{2})\-(0[1-9]|[12][0-8])\-(0[1-9]|1[0-9]|2[0-9]|30|31))*\z/
  
  mount_uploader :photo, PictureUploader
  
end
