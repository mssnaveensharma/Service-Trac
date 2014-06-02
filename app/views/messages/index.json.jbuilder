json.array!(@messages) do |message|
  json.extract! message, :id, :FromUserId, :ToUserId, :MessageContent
  json.url message_url(message, format: :json)
end
