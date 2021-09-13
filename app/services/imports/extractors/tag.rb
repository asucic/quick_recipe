# frozen_string_literal: true

module Services
  module Imports
    module Exctractors
      class Tag
        attr_accessor :rows, :values

        def initialize
          @rows = []
          @values = {}
        end

        def prepare(data, row)
          data['tags'].compact.each_with_index do |tag, index|
            values = {
              "recipe_id_#{row}_#{index}".to_sym => row + 1,
              "name_#{row}_#{index}".to_sym => tag.titleize,
            }

            @rows << "(:#{values.keys.join(", :")})"
            @values = @values.merge(values)
          end
        end

        def get_drop_query
          <<-SQL
            DROP TABLE IF EXISTS _import_recipe_tag
          SQL
        end

        def get_create_query
          <<-SQL
            CREATE TABLE _import_recipe_tag (
              recipe_id INT NOT NULL,
              `name` TEXT NULL
            )
          SQL
        end

        def get_insert_query
          <<-SQL
              INSERT INTO _import_recipe_tag
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
