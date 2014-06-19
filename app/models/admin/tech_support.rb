class Admin::TechSupport < ActiveRecord::Base
  has_many :users
  validates :SupportDescription, presence: true,length: { maximum: 25 }
  validates :Contact, presence: true,length: { maximum: 15 },numericality: { only_integer: true, message: "is not a valid number" }
end
