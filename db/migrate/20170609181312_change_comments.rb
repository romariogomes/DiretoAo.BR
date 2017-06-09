class ChangeComments < ActiveRecord::Migration[5.1]
  def change
  	change_column :comments, :comment_father, :integer, null: true
  end
end
