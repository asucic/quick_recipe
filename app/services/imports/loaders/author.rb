# frozen_string_literal: true

module Imports
  module Loaders
    class Author
      def load
        ActiveRecord::Base.connection.execute(
          <<-SQL
            INSERT INTO authors
              (`name`, created_at, updated_at)
            SELECT DISTINCT
              author, NOW(), NOW()
            FROM
              _import_recipe
          SQL
        )
      end
    end
  end
end
