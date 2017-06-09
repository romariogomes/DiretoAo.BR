class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.string :charge_name

      t.timestamps
    end
  end
end
