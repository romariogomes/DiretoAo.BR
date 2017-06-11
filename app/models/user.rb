class User < ApplicationRecord

	has_secure_password
	validates :password, presence: true, length: {minimum: 6}
  	VALID_EMAIL_FORMAT= /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  	validates :email, presence: true, length: {maximum: 260}, format: { with: VALID_EMAIL_FORMAT}, uniqueness: {case_sensitive: false}
  	before_save { self.email = email.downcase }

	has_many :interactions
    has_many :comments, through: :interactions
    has_many :acceptances, through: :interactions
    
    validates :name, presence:true
end
