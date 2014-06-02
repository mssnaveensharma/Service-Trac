json.array!(@admin_eobr_models) do |admin_eobr_model|
  json.extract! admin_eobr_model, :id, :Name, :EobrMake_id
  json.url admin_eobr_model_url(admin_eobr_model, format: :json)
end
