class Acceptance < ApplicationRecord
	belongs_to :interaction

	validates_inclusion_of :like, :in => [true, false]
end
