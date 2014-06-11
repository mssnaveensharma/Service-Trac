class Message < ActiveRecord::Base
	validates :MessageContent, presence: true
	validates :ToUserId, presence: true
end
