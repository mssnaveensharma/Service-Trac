class Admin::EobrMake < ActiveRecord::Base
	validates :Name, presence: true,length: { maximum: 50 }
end
