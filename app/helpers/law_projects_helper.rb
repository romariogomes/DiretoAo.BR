module LawProjectsHelper

	def load_politicians
		@politicians = Politician.all
	end
end
