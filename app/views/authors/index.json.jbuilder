json.array!(@authors) do |author|
  json.extract! author, :name, :surname
  json.url author_url(author, format: :json)
end