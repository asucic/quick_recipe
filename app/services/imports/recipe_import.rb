# frozen_string_literal: true

Dir[File.join(__dir__, 'extractors', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'loaders', '*.rb')].each { |file| require file }

module Services
  module Imports
    class RecipeImport
      def initialize
        @extractors = [
          Exctractors::Recipe.new,
          Exctractors::Ingredient.new,
          Exctractors::Tag.new,
        ]

        @loaders = [
          Loaders::Author.new,
          Loaders::Budget.new,
          Loaders::Difficulty.new,
          Loaders::Ingredient.new,
          Loaders::Tag.new,
          Loaders::Recipe.new,
          Loaders::IngredientRecipe.new,
          Loaders::RecipeTag.new,
          Loaders::RecipeAuthorTip.new,
          Loaders::RecipeImage.new,
          Loaders::RecipeRate.new,
        ]
      end

      def load_recipe_tables
        @loaders.each do |loader|
          loader.load
        end
      end

      def bulk_import_recipe(lines)
        database_cleanup
        database_setup

        lines.with_index do |line, index|
          insert_data if index % 100 == 99
          parse_data(line, index)
        end

        insert_data
      end

      private
        def parse_data(line, index)
          @extractors.each do |extractor|
            extractor.prepare(JSON.parse(line), index)
          end
        end

        def insert_data
          @extractors.each do |extractor|
            run_insert_query(extractor)
          end
        end

        def run_insert_query(extractor)
          query = extractor.get_insert_query % extractor.rows.join(",\n")
          query = ActiveRecord::Base.send(:sanitize_sql_array, [query, extractor.values])
          ActiveRecord::Base.connection.execute(query)

          extractor.rows = []
          extractor.values = {}
        end

        def database_cleanup
          @extractors.each do |extractor|
            ActiveRecord::Base.connection.execute(extractor.get_drop_query)
          end
        end

        def database_setup
          @extractors.each do |extractor|
            ActiveRecord::Base.connection.execute(extractor.get_create_query)
          end
        end
    end
  end
end