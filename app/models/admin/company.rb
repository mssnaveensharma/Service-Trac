class Admin::Company < ActiveRecord::Base
  has_many :users
  validates :CompanyName, presence: true,length: { maximum: 50 }
  validates :Address, presence: true,length: { maximum: 60 }
  validates :City, presence: true,length: { maximum: 15 }
  validates :State, presence: true,length: { maximum: 20 }
  validates :Zip, presence: true, numericality: { only_integer: true, message: "is not a valid number" },length: { maximum: 15 }
  validates :Telephone, presence: true,length: { maximum: 20 }
  validates :Fax, presence: true, numericality: { only_integer: true, message: "is not a valid number" },length: { maximum: 15 }
  validates :Email, presence: true,uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "is not valid" }
  validates :ContactName, presence: true,length: { maximum: 20 }
end
