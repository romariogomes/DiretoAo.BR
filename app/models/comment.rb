class Comment < ApplicationRecord
	belongs_to :interaction

	validates :description, presence:true
end
