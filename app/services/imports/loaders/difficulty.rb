# frozen_string_literal: true

module Services
  module Imports
    module Loaders
      class Difficulty
        def load
          ActiveRecord::Base.connection.execute(
            <<-SQL
              INSERT INTO difficulties
                (`name`, created_at, updated_at)
              SELECT DISTINCT
                difficulty, NOW(), NOW()
              FROM
                _import_recipe
            SQL
          )
        end
      end
    end
  end
end
