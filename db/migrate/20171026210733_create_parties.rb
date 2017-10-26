class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.string :name
      t.string :orientation

      t.timestamps
    end
  end
end
