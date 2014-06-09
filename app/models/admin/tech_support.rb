class Admin::TechSupport < ActiveRecord::Base
  has_many :users
  validates :SupportDescription, presence: true
end
