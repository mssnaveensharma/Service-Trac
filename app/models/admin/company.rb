class Admin::Company < ActiveRecord::Base
  has_many :users
  validates :CompanyName, presence: true
end
