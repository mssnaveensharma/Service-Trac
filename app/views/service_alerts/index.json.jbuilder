json.array!(@service_alerts) do |service_alert|
  json.extract! service_alert, :id
  json.url service_alert_url(service_alert, format: :json)
end
