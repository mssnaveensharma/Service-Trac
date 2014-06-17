class Admin::EobrMake < ActiveRecord::Base
	validates :Name, presence: true,length: { maximum: 50 }
	validates :Contact, presence: true, length: { maximum: 15 }
end
