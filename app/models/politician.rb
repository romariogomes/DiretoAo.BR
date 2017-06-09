class Politician < ApplicationRecord
	belongs_to :state
	belongs_to :charge
	has_many :experiences
	has_many :notices
	has_many :politician_laws
end
