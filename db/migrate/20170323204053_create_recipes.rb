class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :chef_id

      t.timestamps
    end
  end
end
