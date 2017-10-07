class RankingController < ApplicationController

	def index
		loadRanking
	end

	def loadRanking
		
		interactions = Interaction.where(user_id: current_user.id)
		acceptancesList = Array.new
		
		interactions.each do |i|
	        
        	if (!i.acceptance.nil?)
          		acceptancesList.push(i)
          	end
        end

        writeFile(acceptancesList)
      

	end

	def data
	     respond_to do |format|
	      format.json {
	       render :json => [1,2,3,4,5]
	        }
	     end
    end

    def writeFile(acceptancesList)

    	
    	file = File.new "public/aeo.csv", "w"

    	if ( !(acceptancesList.empty?) &&  !(acceptancesList.nil?) )

    		acceptancesList.each do |a|
			    require 'pry'
			    binding.pry
		    	file.puts a.law_project.politicians.first.party, a.law_project.politicians.first.name, "\n"
		        	
		    end

	    # 	file = "aeo.txt"
		  	# File.open(file, "w") do |csv|
				  	
		   #  	acceptancesList.each do |a|
			        
		   #  		csv << [a.law_project.politicians.first.party, a.law_project.politicians.first.name, "\n"]       
		        	
		   #      end
	  		# end	
	    end
    	
    	

    	
    end
end
