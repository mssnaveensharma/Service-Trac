class Admin::EobrModel < ActiveRecord::Base
  belongs_to :eobr_make
  has_many :users
  validates :EobrMake_id, presence: true
  validates :Name, presence: true
end
