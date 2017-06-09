class Politician < ApplicationRecord
	belongs_to :state
    belongs_to :charge
    has_many :experiences
    has_many :notices
    has_many :politician_laws
    has_many :law_projects, through: :politician_laws
    
    validates :name, presence:true
    validates :birthdate, presence:true
    validates :party, presence:true
    validates :photo, presence:true
end
