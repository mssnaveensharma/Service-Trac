class Admin::Company < ActiveRecord::Base
  has_many :users
end
