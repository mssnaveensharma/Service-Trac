json.array!(@admin_service_centers) do |admin_service_center|
  json.extract! admin_service_center, :id, :Name, :StreetAddress, :State, :StateCode, :City, :Pin, :Tel, :Fax, :Email, :Url, :ContactPerson, :lat, :lan, :distance, :time
  json.url admin_service_center_url(admin_service_center, format: :json)
end
