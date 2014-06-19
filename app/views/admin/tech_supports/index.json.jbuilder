json.array!(@admin_tech_supports) do |admin_tech_support|
  json.extract! admin_tech_support, :id, :SupportDescription, :Contact
  json.url admin_tech_support_url(admin_tech_support, format: :json)
end
