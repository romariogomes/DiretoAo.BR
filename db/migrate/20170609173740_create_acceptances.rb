class CreateAcceptances < ActiveRecord::Migration[5.1]
  def change
    create_table :acceptances do |t|
      t.boolean :like

      t.timestamps
    end
  end
end
