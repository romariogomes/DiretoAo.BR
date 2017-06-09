class CreateLawProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :law_projects do |t|
      t.integer :law_number
      t.text :description
      t.date :date

      t.timestamps
    end
  end
end
