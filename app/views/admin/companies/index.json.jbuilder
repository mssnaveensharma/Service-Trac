json.array!(@admin_companies) do |admin_company|
  json.extract! admin_company, :id, :CompanyName
  json.url admin_company_url(admin_company, format: :json)
end
