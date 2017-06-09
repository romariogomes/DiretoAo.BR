class Interaction < ApplicationRecord
	belongs_to :user
	belongs_to :law_project
	belongs_to :notice
	has_one comment
	has_one acceptance
end
