json.array!(@users_service_centers) do |users_service_center|
  json.extract! users_service_center, :id
  json.url users_service_center_url(users_service_center, format: :json)
end
