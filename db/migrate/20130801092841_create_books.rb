class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.integer :author_id
      t.string :language
      t.string :description
      t.string :photo
      t.integer :quantity
      t.string :place
      t.date :release_date
      t.integer :pages

      t.timestamps
    end
  end
end
