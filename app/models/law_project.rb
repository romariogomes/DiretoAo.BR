class LawProject < ApplicationRecord
	has_many :interactions
    has_many :politician_laws
    has_many :politicians, through: :politician_laws
    has_many :comments, through: :interactions
    has_many :acceptances, through: :interactions
    
    validates :law_number, presence:true
    validates :description, presence:true
    validates :date, presence:true
end
