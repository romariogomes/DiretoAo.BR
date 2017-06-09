class Notice < ApplicationRecord
	belongs_to :politician
    has_many :interactions
    has_many :comments, through: :interactions
    has_many :acceptances, through: :interactions
    
    validates :title, presence:true
    validates :url, presence:true
end
