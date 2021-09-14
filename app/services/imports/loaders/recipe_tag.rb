# frozen_string_literal: true

module Imports
  module Loaders
    class RecipeTag
      def load
        ActiveRecord::Base.connection.execute(
          <<-SQL
            INSERT INTO recipes_tags
              (recipe_id, tag_id)
            SELECT
              ir.recipe_id, t.id
            FROM
              _import_recipe ir
              JOIN _import_recipe_tag irt
                ON ir.recipe_id = irt.recipe_id
              JOIN tags t
                ON irt.name = t.name
          SQL
        )
      end
    end
  end
end
