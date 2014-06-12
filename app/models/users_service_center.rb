class UsersServiceCenter < ActiveRecord::Base
	validates :service_center_id, presence: true
	validates :user_id, presence: true

  def encrypt_password
	if password.present?
	  self.password_salt = BCrypt::Engine.generate_salt
	  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end
  end
end
