class Interaction < ApplicationRecord
	belongs_to :user
    belongs_to :law_project, optional: true
    belongs_to :notice, optional: true
    has_one :comment, dependent: :destroy
    has_one :acceptance, dependent: :destroy
    
    validates :user, presence:true
end
