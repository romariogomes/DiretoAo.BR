class CreatePoliticianLaws < ActiveRecord::Migration[5.1]
  def change
    create_table :politician_laws do |t|
      t.references :politician, foreign_key: true
      t.references :law_project, foreign_key: true

      t.timestamps
    end
  end
end
