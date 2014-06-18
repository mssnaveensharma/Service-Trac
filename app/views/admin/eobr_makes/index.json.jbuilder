json.array!(@admin_eobr_makes) do |admin_eobr_make|
  json.extract! admin_eobr_make, :id, :Name, :Contact
  json.url admin_eobr_make_url(admin_eobr_make, format: :json)
end
