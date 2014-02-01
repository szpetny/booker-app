class CreateBookCategoriesBooksJoin < ActiveRecord::Migration
  def change
    create_table :book_categories_books, :id => false do |t|
       t.column 'book_id', :integer
       t.column 'book_category_id', :integer
    end
  end
end
