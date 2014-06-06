class Message < ActiveRecord::Base
	validates :MessageContent, presence: true
end
