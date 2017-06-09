class AddForeignKeyToInteractions < ActiveRecord::Migration[5.1]
  def change
    add_reference :interactions, :user, foreign_key: true
    add_reference :interactions, :law_project, foreign_key: true
    add_column :interactions, :notice_references, :string
  end
end
