class Admin::EobrMake < ActiveRecord::Base
	validates :Name, presence: true
end
