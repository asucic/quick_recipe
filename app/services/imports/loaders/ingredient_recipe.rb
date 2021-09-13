# frozen_string_literal: true

module Services
  module Imports
    module Loaders
      class IngredientRecipe
        def load
          ActiveRecord::Base.connection.execute(
            <<-SQL
              INSERT INTO ingredients_recipes
                (ingredient_id, recipe_id)
              SELECT
                i.id, ir.recipe_id
              FROM
                _import_recipe ir
                JOIN _import_recipe_ingredient iri
                  ON ir.recipe_id = iri.recipe_id
                JOIN ingredients i
                  ON iri.name = i.name
            SQL
          )
        end
      end
    end
  end
end
