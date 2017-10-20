class RankingController < ApplicationController

	def index

        if @lawProjectsAcceptancesCount.nil?
            @lawProjectsAcceptancesCount = countAllPoliticianLawsAcceptances    
        end

        require 'pry'

        if @rankingByAcceptanceAverage.nil?
            @rankingByAcceptanceAverage = sortByAverageOfAcceptances.sort.reverse
        end    

        binding.pry    

        # if @rankingByProjectsNumber.nil?
        #     @rankingByProjectsNumber = sortByProjectsCreated.sort_by{|key,value| value}.reverse
        # end

        if !(current_user.nil?)
            loadRanking    
        end
	end

	def loadRanking
		
		interactions = Interaction.where(user_id: current_user.id)
		acceptancesList = Array.new
		politicianList = Array.new
		
		interactions.each do |i|
	        
        	if (!i.acceptance.nil?)
          		acceptancesList.push(i)

          	end
        end

        countPolitician(acceptancesList)      

	end

	def data
        respond_to do |format|
          format.json {
           render :json => [1,2,3,4,5]
            }
        end
    end

    def countPolitician(acceptancesList)
    	
    	politiciansCount = Hash.new

    	acceptancesList.each do |a|
	    	if politiciansCount.has_key?(a.law_project.politicians.first.name)
	    		politiciansCount[a.law_project.politicians.first.name] = politiciansCount.values_at(a.law_project.politicians.first.name)[0]+1
	    	else
	    		politiciansCount.store(a.law_project.politicians.first.name, 1)
	    	end	
        end

        mountFile(acceptancesList, politiciansCount)
    end

    def mountFile(acceptancesList, politiciansCount)

    	lines = Array.new
    	
    	politiciansCount.each {|key, value| 
    		politician = Politician.where(name: key).first
    		lines.push(politician.party+"-"+politician.name+","+value.to_s) 
    	}

    	writeFile(lines)

    end

    def writeFile(lines)

    	file = File.new "public/politicianAccepted.csv", "w"

    	if ( !(lines.empty?) &&  !(lines.nil?) )
    		
    		lines.each do |a|			    
		    	file.puts a
		    end

	  		file.close
	    end
    	
    end

    def countAllPoliticianLawsAcceptances

        # method to count all law projects acceptances

        allAcceptances = Acceptance.all
        lawProjectsCount = Hash.new

        allAcceptances.each do |a|

            startHash = {
              :acceptances => {:like => 0, :dislike => 0}
            }

            politicianName = (a.interaction.law_project.politicians.first.name).to_sym
            lawProjectId = a.interaction.law_project.id

            if lawProjectsCount.has_key?(politicianName)

                if !(lawProjectsCount[politicianName].has_key?(a.interaction.law_project.id))
                    lawProjectsCount[politicianName].store(lawProjectId, startHash)                  
                end
            else
                lawProjectsCount.store(politicianName, lawProjectId => startHash)
            end 
            
            lawProjectsCount = incrementAcceptance(a, lawProjectsCount)
        end

        return lawProjectsCount
    end

    def incrementAcceptance(acceptance, hash)

        politicianName = (acceptance.interaction.law_project.politicians.first.name).to_sym
        lawProjectId = acceptance.interaction.law_project.id
        valueLike = hash[politicianName][lawProjectId][:acceptances][:like]
        valueDislike = hash[politicianName][lawProjectId][:acceptances][:dislike]

        if acceptance.like
           hash[politicianName][lawProjectId][:acceptances][:like] = valueLike+=1
        else
           hash[politicianName][lawProjectId][:acceptances][:dislike] = valueDislike+=1 
        end

        return hash
    end

    def sortByProjectsCreated

        # method that rank the politicians by number of law projects created
        
        numberOfProjects = Hash.new
        lawProjectsCount = @lawProjectsAcceptancesCount
        
        lawProjectsCount.each do |key, value|
          numberOfProjects.store(key, value.size)
        end
        
        return numberOfProjects
        
    end

    def sortByAverageOfAcceptances
        
        # method that rank the politicians by acceptances average on law projects

        allProjectsAverage = Hash.new
        eachProjectAverage = Hash.new
        lawProjectsCount = @lawProjectsAcceptancesCount

        lawProjectsCount.each do |key, value|
          
          numberOfProjects = value.size

          value.each do |k,v|
            acceptanceAverage = (v[:acceptances][:like].to_f/(v[:acceptances][:like]+v[:acceptances][:dislike]))*100
            eachProjectAverage.store(value.keys[0], acceptanceAverage)
          end

          sumOfAverage = 0

          eachProjectAverage.each do |lawProjectId, average|
            sumOfAverage = sumOfAverage+=average
          end

          allProjectsAverage.store(key, (sumOfAverage/eachProjectAverage.size).round(2))

          eachProjectAverage.clear

        end

        return allProjectsAverage

    end

end
