class CreatePoliticians < ActiveRecord::Migration[5.1]
  def change
    create_table :politicians do |t|
      t.string :name
      t.date :birthdate
      t.string :party
      t.string :photo

      t.timestamps
    end
  end
end
