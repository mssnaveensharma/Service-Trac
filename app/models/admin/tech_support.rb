class Admin::TechSupport < ActiveRecord::Base
  has_many :users
  validates :SupportDescription, presence: true,length: { maximum: 25 }
end
