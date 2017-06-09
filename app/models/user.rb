class User < ApplicationRecord
	has_many :interactions
    has_many :comments, through: :interactions
    has_many :acceptances, through: :interactions
    
    validates :name, presence:true
    validates :email, presence:true
end
