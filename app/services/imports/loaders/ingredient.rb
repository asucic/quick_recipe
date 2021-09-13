# frozen_string_literal: true

module Services
  module Imports
    module Loaders
      class Ingredient
        def load
          ActiveRecord::Base.connection.execute(
            <<-SQL
              INSERT INTO ingredients
                (`name`, created_at, updated_at)
              SELECT DISTINCT
                `name`, NOW(), NOW()
              FROM
                _import_recipe_ingredient
            SQL
          )
        end
      end
    end
  end
end
