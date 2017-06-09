class PoliticianLaw < ApplicationRecord
  belongs_to :politician
  belongs_to :law_project
end
