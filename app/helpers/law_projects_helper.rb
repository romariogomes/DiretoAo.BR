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
end
