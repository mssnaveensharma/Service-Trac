class Admin::EobrModel < ActiveRecord::Base
  belongs_to :eobr_make
  has_many :users
end
