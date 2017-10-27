class AddAbstractToLawProject < ActiveRecord::Migration[5.1]
  def change
    add_column :law_projects, :abstract, :text
  end
end
