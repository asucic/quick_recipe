# frozen_string_literal: true

module Services
  module Imports
    module Loaders
      class Budget
        def load
          ActiveRecord::Base.connection.execute(
            <<-SQL
              INSERT INTO budgets
                (`name`, created_at, updated_at)
              SELECT DISTINCT
                budget, NOW(), NOW()
              FROM
                _import_recipe
            SQL
          )
        end
      end
    end
  end
end
