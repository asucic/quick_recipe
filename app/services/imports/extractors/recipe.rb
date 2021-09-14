# frozen_string_literal: true

module Services
  module Imports
    module Exctractors
      class Recipe
        attr_accessor :rows, :values

        def initialize
          @rows = []
          @values = {}
        end

        def prepare(data, row)
          values = {
            "recipe_id_#{row}".to_sym => row + 1,
            "author_#{row}".to_sym => get_title(data['author']),
            "author_tip_#{row}".to_sym => get_title(data['author_tip']),
            "budget_#{row}".to_sym => get_title(data['budget']),
            "cook_time_#{row}".to_sym => get_title(data['cook_time']),
            "difficulty_#{row}".to_sym => get_title(data['difficulty']),
            "image_#{row}".to_sym => get_title(data['image']),
            "name_#{row}".to_sym => get_title(data['name']),
            "nb_comments_#{row}".to_sym => get_title(data['nb_comments']),
            "people_quantity_#{row}".to_sym => get_title(data['people_quantity']),
            "prep_time_#{row}".to_sym => get_title(data['prep_time']),
            "rate_#{row}".to_sym => get_title(data['rate']),
            "total_time_#{row}".to_sym => get_title(data['total_time'])
          }

          @rows << "(:#{values.keys.join(', :')})"
          @values = @values.merge(values)
        end

        def drop_query
          <<-SQL
            DROP TABLE IF EXISTS _import_recipe
          SQL
        end

        def create_query
          <<-SQL
            CREATE TABLE _import_recipe (
              recipe_id INT NOT NULL,
              author TEXT NULL,
              author_tip TEXT NULL,
              budget TEXT NULL,
              cook_time TEXT NULL,
              difficulty TEXT NULL,
              `image` TEXT NULL,
              `name` TEXT NULL,
              nb_comments TEXT NULL,
              people_quantity TEXT NULL,
              prep_time TEXT NULL,
              rate TEXT NULL,
              total_time TEXT NULL
            )
          SQL
        end

        def insert_query
          <<-SQL
              INSERT INTO _import_recipe
              (
                recipe_id,
                author,
                author_tip,
                budget,
                cook_time,
                difficulty,
                `image`,
                `name`,
                nb_comments,
                people_quantity,
                prep_time,
                rate,
                total_time
              )
              VALUES
                %s
          SQL
        end

        private

        def get_title(value)
          value.blank? ? nil : value.titleize
        end
      end
    end
  end
end
