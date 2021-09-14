# frozen_string_literal: true

module Imports
  module Loaders
    class RecipeRate
      def load
        ActiveRecord::Base.connection.execute(
          <<-SQL
            INSERT INTO recipe_rates
              (recipe_id, `name`, created_at, updated_at)
            SELECT
              recipe_id, rate, NOW(), NOW()
            FROM
              _import_recipe
            WHERE
              rate IS NOT NULL
          SQL
        )
      end
    end
  end
end
