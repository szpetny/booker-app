json.array!(@book_categories) do |book_category|
  json.extract! book_category, :category_name
  json.url book_category_url(book_category, format: :json)
end