class Party < ApplicationRecord
	has_many :politicians, through: :politicians

	def social_orientation
		
	end

	def economic_orientation
		
	end
end
