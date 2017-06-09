class AddForeignKeyToAcceptances < ActiveRecord::Migration[5.1]
  def change
    add_reference :acceptances, :interaction, foreign_key: true
  end
end
