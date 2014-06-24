json.array!(@alert_details) do |alert_detail|
  json.extract! alert_detail, :id
  json.url alert_detail_url(alert_detail, format: :json)
end
