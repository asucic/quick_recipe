class CreateRecipeImages < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_images do |t|
      t.bigint :recipe_id
      t.string :name

      t.timestamps
    end
  end
end
