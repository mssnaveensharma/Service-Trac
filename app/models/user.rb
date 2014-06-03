class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  #belongs_to :tech_support
  belongs_to :eobr_make
  belongs_to :eobr_model

  validates :eobr_make_id, presence: true
  validates :eobr_model_id, presence: true
  validates :EobrNumber, presence: true
  validates :TruckNumber, presence: true
  validates :TruckMake, presence: true
  validates :TruckYear, presence: true
  validates :TruckOwner, presence: true
  validates :company_id, presence: true
  validates :FirstName, presence: true
  validates :LastName, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,message: "is not valid" }
  validates :password, presence: true
  validates :tech_support_id, presence: true
  validates :Contact, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
  
end
