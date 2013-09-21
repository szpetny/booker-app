class Book < ActiveRecord::Base
  belongs_to :author
  validates :author_id, presence: true
  validates :isbn, presence: true, format: /[\-0-9]+/
  validates :title, presence: true
  validates :quantity, numericality: true
  validates :pages, numericality: true
  validates :place, presence: true
  
  mount_uploader :photo, PictureUploader
  
end
