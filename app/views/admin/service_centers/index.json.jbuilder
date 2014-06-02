json.array!(@admin_service_centers) do |admin_service_center|
  json.extract! admin_service_center, :id, :Name, :State, :City, :Pin, :Tel, :Fax, :Email, :Url, :ContactPerson
  json.url admin_service_center_url(admin_service_center, format: :json)
end
