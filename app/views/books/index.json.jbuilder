json.array!(@books) do |book|
  json.extract! book, :isbn, :title, :author_id, :language, :description, :photo, :quantity, :place, :release_date, :pages
  json.url book_url(book, format: :json)
end