class Admin::ServiceCenter < ActiveRecord::Base
	validates :Name, presence: true,length: { maximum: 50 }
	validates :State, presence: true,length: { maximum: 50 }
	validates :StateCode, presence: true,length: { maximum: 50 }
	validates :City, presence: true,length: { maximum: 50 }
	validates :Pin, presence: true, numericality: { only_integer: true, message: "is not a valid number" },length: { maximum: 15 }
	validates :Tel, presence: true, numericality: { only_integer: true, message: "is not a valid number" },length: { maximum: 15 }
	validates :Fax, presence: true, numericality: { only_integer: true, message: "is not a valid number" },length: { maximum: 15 }
	validates :Email, presence: true,uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "is not valid" }
	validates :Url, presence: true, format:{ with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,message: "is not valid" }
	validates :ContactPerson, presence: true,length: { maximum: 20 }
	validates :lat, presence: true, numericality: {only_float: true, message: "is not a valid latitude"},length: { maximum: 20 }
	validates :lan, presence: true, numericality: {only_float: true, message: "is not a valid longnitude"},length: { maximum: 20 }
	validates :StreetAddress, presence: true,length: { maximum: 50 }
end
