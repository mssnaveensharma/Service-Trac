class Admin::ServiceCenter < ActiveRecord::Base
	validates :Name, presence: true
	validates :State, presence: true
	validates :StateCode, presence: true
	validates :City, presence: true
	validates :Pin, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
	validates :Tel, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
	validates :Fax, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
	validates :Email, presence: true,uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "is not valid" }
	validates :Url, presence: true, format:{ with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,message: "is not valid" }
	validates :ContactPerson, presence: true
	validates :lat, presence: true
	validates :lan, presence: true
	validates :StreetAddress, presence: true
end
