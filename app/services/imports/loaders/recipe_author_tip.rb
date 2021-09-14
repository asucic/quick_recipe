# frozen_string_literal: true

module Imports
  module Loaders
    class RecipeAuthorTip
      def load
        ActiveRecord::Base.connection.execute(
          <<-SQL
            INSERT INTO recipe_author_tips
              (recipe_id, `name`, created_at, updated_at)
            SELECT
              recipe_id, author_tip, NOW(), NOW()
            FROM
              _import_recipe
            WHERE
              author_tip IS NOT NULL
          SQL
        )
      end
    end
  end
end
