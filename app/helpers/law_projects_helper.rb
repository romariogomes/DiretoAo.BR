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
		@interaction.law_project_id = params['acceptance']['law_project_id']
		
		@interaction.save
	end

	def load_all_comments(law_project_id)
		@all_comments = Interaction.where(law_project_id: law_project_id)
	end
end
