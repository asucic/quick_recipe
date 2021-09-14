# frozen_string_literal: true

module Imports
  module Loaders
    class Tag
      def load
        ActiveRecord::Base.connection.execute(
          <<-SQL
            INSERT INTO tags
              (`name`, created_at, updated_at)
            SELECT DISTINCT
              `name`, NOW(), NOW()
            FROM
              _import_recipe_tag
          SQL
        )
      end
    end
  end
end
