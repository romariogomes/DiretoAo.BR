class Acceptance < ApplicationRecord
	belongs_to :interaction

	validates :like, presence:true
end
