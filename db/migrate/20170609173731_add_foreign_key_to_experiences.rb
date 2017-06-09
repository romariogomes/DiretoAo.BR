class AddForeignKeyToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_reference :experiences, :politician, foreign_key: true
  end
end
