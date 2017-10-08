class RankingController < ApplicationController

	def index
		loadRanking
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
end
