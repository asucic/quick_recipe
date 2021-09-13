# frozen_string_literal: true

module Services
  module Imports
    module Loaders
      class Recipe
        def load
          ActiveRecord::Base.connection.execute(
            <<-SQL
              INSERT INTO recipes
              (
                id,
                `name`,
                people_quantity,
                prep_time,
                cook_time,
                total_time,
                nb_comments,
                author_id,
                budget_id,
                difficulty_id,
                created_at,
                updated_at
              )
              SELECT
                ir.recipe_id,
                ir.name,
                ir.people_quantity,
                ir.prep_time,
                ir.cook_time,
                ir.total_time,
                ir.nb_comments,
                a.id,
                b.id,
                d.id,
                NOW(),
                NOW()
              FROM
                _import_recipe ir
                LEFT JOIN authors a
                  ON ir.author = a.name
                LEFT JOIN budgets b
                  ON ir.budget = b.name
                LEFT JOIN difficulties d
                  ON ir.difficulty = d.name
            SQL
          )
        end
      end
    end
  end
end
