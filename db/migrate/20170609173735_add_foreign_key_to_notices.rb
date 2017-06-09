class AddForeignKeyToNotices < ActiveRecord::Migration[5.1]
  def change
    add_reference :notices, :politician, foreign_key: true
  end
end
