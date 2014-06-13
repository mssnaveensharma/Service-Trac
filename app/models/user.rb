class User < ActiveRecord::Base
  before_save :encrypt_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  #belongs_to :tech_support
  belongs_to :eobr_make
  belongs_to :eobr_model

=begin
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
    validates :Contact, presence: true,length: { maximum: 10 }, numericality: { only_integer: true, message: "is not a valid number" }
=end
  
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

def self.update_password(email,new_password)
    user = find_by_email(email)
    if user 
      BCrypt::Engine.hash_secret(new_password, user.password_salt)
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
