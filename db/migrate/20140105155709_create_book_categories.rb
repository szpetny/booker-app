class CreateBookCategories < ActiveRecord::Migration
  def change
    create_table :book_categories do |t|
      t.string :category_name

      t.timestamps
    end
  end
end
