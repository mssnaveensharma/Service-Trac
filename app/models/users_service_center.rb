class UsersServiceCenter < ActiveRecord::Base
	validates :service_center_id, presence: true
	validates :user_id, presence: true
end
