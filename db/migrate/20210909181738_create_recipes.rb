class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :people_quantity
      t.string :prep_time
      t.string :cook_time
      t.string :total_time
      t.integer :nb_comments

      t.timestamps
    end
  end
end
