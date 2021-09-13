# frozen_string_literal: true

class AddRecipeRelationships < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :author_id, :integer
    add_index  :recipes, :author_id
    add_column :recipes, :budget_id, :integer
    add_index  :recipes, :budget_id
    add_column :recipes, :difficulty_id, :integer
    add_index  :recipes, :difficulty_id

    create_join_table :recipes, :tags do |t|
      t.index :recipe_id
      t.index :tag_id
    end

    create_join_table :ingredients, :recipes do |t|
      t.index :ingredient_id
      t.index :recipe_id
    end
  end
end
