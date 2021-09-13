# frozen_string_literal: true

module Services
  module Imports
    module Loaders
      class RecipeImage
        def load
          ActiveRecord::Base.connection.execute(
            <<-SQL
              INSERT INTO recipe_images
                (recipe_id, `name`, created_at, updated_at)
              SELECT
                recipe_id, `image`, NOW(), NOW()
              FROM
                _import_recipe
              WHERE
                `image` IS NOT NULL
            SQL
          )
        end
      end
    end
  end
end
