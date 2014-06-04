class ServiceAlert < ActiveRecord::Base
	validates :user_id, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
	validates :service_center_id, presence: true, , numericality: { only_integer: true, message: "is not a valid number" }
	validates :status, presence: true
end
