class Admin::Company < ActiveRecord::Base
  has_many :users
  validates :CompanyName, presence: true,length: { maximum: 50 }
end
