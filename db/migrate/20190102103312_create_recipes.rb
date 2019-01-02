class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :category
      t.text :instructions
      t.string :image
      t.string :video

      t.timestamps
    end
  end
end
