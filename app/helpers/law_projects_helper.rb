module LawProjectsHelper

	def load_politicians
		@politicians = Politician.all
	end

	def create_interaction
		
		@interaction = Interaction.new
		@interaction.user = current_user if logged_in?
		@interaction.law_project_id = params['comment']['law_project_id']
	
		@interaction.save		
	end

	def create_interaction_acceptance
		
		@interaction = Interaction.new
		@interaction.user = current_user if logged_in?
		@interaction.law_project_id = params[:law_project]
		
		@interaction.save
	end

	def load_all_interactions(law_project_id)
		return Interaction.where(law_project_id: law_project_id)
	end

	def load_all_comments(law_project_id)
		comments = load_all_interactions(law_project_id).to_a
		
		@all_comments = []

		comments.each do |c|
			if ((!c.comment.nil?) && (c.acceptance.nil?))
				@all_comments.push(c)
			end
		end
	end

	def load_all_acceptances(law_project_id)
		acceptances = load_all_interactions(law_project_id).to_a
		
		@all_acceptances = []
		acceptances.each do |a|
			if ((!a.acceptance.nil?) && (a.comment.nil?))
				@all_acceptances.push(a)	
			end
		end
	end

	def load_user_acceptance
		
		@all_acceptances.each do |a|
			
			next if (!a.user_id.eql?(current_user.id))
			
			if (a.user_id.eql?(current_user.id))
				@acceptanceUser = a
				break
			end
		end
	end
end
