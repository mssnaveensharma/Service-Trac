json.array!(@service_center_reviews) do |service_center_review|
  json.extract! service_center_review, :id
  json.url service_center_review_url(service_center_review, format: :json)
end
