class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :title
      t.integer :init_year
      t.integer :end_year

      t.timestamps
    end
  end
end
