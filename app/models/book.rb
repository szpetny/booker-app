class Book < ActiveRecord::Base
  belongs_to :author
  validates :author_id, presence: true
  validates :isbn, presence: true, format: /[\-0-9]+/
  validates :title, presence: true
  validates :quantity, numericality: {greater_than: 0}, :unless => Proc.new {|book| book.quantity.nil? }
  validates :pages, numericality: {greater_than: 0}, :unless => Proc.new {|book| book.pages.nil? }
  validates :place, presence: true
  
  mount_uploader :photo, PictureUploader
  
end
