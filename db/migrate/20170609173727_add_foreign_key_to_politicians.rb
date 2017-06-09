class AddForeignKeyToPoliticians < ActiveRecord::Migration[5.1]
  def change
    add_reference :politicians, :charge, foreign_key: true
    add_reference :politicians, :state, foreign_key: true
  end
end
