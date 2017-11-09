class Party < ApplicationRecord
	has_many :politicians, through: :politicians
end
