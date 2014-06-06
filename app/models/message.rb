class Message < ActiveRecord::Base
	scope :reversed, -> { order 'created_at DESC' }
	validates :MessageContent, presence: true
end
