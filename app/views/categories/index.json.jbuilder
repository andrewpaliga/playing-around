json.array!(@categories) do |category|
  json.extract! category, :id, :name, :url, :session
  json.url category_url(category, format: :json)
end
