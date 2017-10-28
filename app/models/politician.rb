class Politician < ApplicationRecord
	belongs_to :state
    belongs_to :charge
    belongs_to :party
    has_many :experiences
    has_many :notices
    has_many :politician_laws
    has_many :law_projects, through: :politician_laws
    
    validates :name, presence:true
    validates :birthdate, presence:true
    validates :party, presence:true
    validates :photo, presence:true

    def age(birthdate)
      now = Time.now.utc.to_date
      now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
    end

    def loadProjectsOnPoliticianPage
        
        law_project_ids = []
        
        politicianLawXref = PoliticianLaw.where(politician_id: self.id)

        politicianLawXref.each do |lp|
            law_project_ids.push(lp.law_project_id)    
        end

        return LawProject.where(id: law_project_ids)
    end

    
end
