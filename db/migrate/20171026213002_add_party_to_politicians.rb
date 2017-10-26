class AddPartyToPoliticians < ActiveRecord::Migration[5.1]
  def change
  	add_reference :politicians, :party, foreign_key: true
  end
end
