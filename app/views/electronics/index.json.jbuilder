json.array!(@electronics) do |electronic|
  json.extract! electronic, :id
  json.url electronic_url(electronic, format: :json)
end
