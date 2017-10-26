class RemovePartyFromPoliticians < ActiveRecord::Migration[5.1]
  def change
    remove_column :politicians, :party, :string
  end
end
