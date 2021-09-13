# frozen_string_literal: true

module Services
  module Imports
    module Exctractors
      class Ingredient
        attr_accessor :rows, :values

        def initialize
          @rows = []
          @values = {}
        end

        def prepare(data, row)
          data['ingredients'].compact.each_with_index do |ingredient, index|
            values = {
              "recipe_id_#{row}_#{index}".to_sym => row + 1,
              "name_#{row}_#{index}".to_sym => ingredient.titleize,
            }

            @rows << "(:#{values.keys.join(", :")})"
            @values = @values.merge(values)
          end
        end

        def get_drop_query
          <<-SQL
            DROP TABLE IF EXISTS _import_recipe_ingredient
          SQL
        end

        def get_create_query
          <<-SQL
            CREATE TABLE _import_recipe_ingredient (
              recipe_id INT NOT NULL,
              `name` TEXT NULL
            );
          SQL
        end

        def get_insert_query
          <<-SQL
              INSERT INTO _import_recipe_ingredient
              (
                recipe_id,
                `name`
              )
              VALUES
                %s
          SQL
        end
      end
    end
  end
end
