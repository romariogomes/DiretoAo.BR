class Experience < ApplicationRecord
	belongs_to :politician
	
	validates :title, presence:true
    validates :init_year, presence:true, length: { is: 4 }
end
