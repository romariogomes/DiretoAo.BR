class ChangeExperiences < ActiveRecord::Migration[5.1]
  def change
  	change_column :experiences, :end_year, :integer, null:true
  end
end
