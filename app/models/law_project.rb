class LawProject < ApplicationRecord
	has_many :interactions
    has_many :politician_laws
    has_many :politicians, through: :politician_laws
    has_many :comments, through: :interactions
    has_many :acceptances, through: :interactions
    
    validates :law_number, presence:true
    validates :description, presence:true
    validates :date, presence:true

    def countAcceptances
        
    	allAcceptances = Acceptance.all
        lawProjectCount = Hash.new

        startHash = {
            :acceptances => {:like => 0, :dislike => 0}
        }

        lawProjectCount.store(self.id, startHash)

        allAcceptances.each do |a|

            if (a.interaction.law_project.id.eql?(self.id))
                lawProjectCount = incrementAcceptance(a, lawProjectCount)    
            end 
            
        end

        return lawProjectCount
        
    end

    def incrementAcceptance(acceptance, hash)

        lawProjectId = acceptance.interaction.law_project.id
        valueLike = hash[lawProjectId][:acceptances][:like]
        valueDislike = hash[lawProjectId][:acceptances][:dislike]

        if acceptance.like
           hash[lawProjectId][:acceptances][:like] = valueLike+=1
        else
           hash[lawProjectId][:acceptances][:dislike] = valueDislike+=1 
        end

        return hash
    end
end
