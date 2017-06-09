class ChangeInteractions < ActiveRecord::Migration[5.1]
  def change
  	change_column :interactions, :law_project_id, :integer, null:true
	change_column :interactions, :notice_id, :integer, null:true
  end
end
