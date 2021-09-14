# frozen_string_literal: true

module Imports
  class RecipeImport
    EXTRACTORS = [
      Imports::Extractors::Recipe.new,
      Imports::Extractors::Ingredient.new,
      Imports::Extractors::Tag.new
    ].freeze

    LOADERS = [
      Imports::Loaders::Author.new,
      Imports::Loaders::Budget.new,
      Imports::Loaders::Difficulty.new,
      Imports::Loaders::Ingredient.new,
      Imports::Loaders::Tag.new,
      Imports::Loaders::Recipe.new,
      Imports::Loaders::IngredientRecipe.new,
      Imports::Loaders::RecipeTag.new,
      Imports::Loaders::RecipeAuthorTip.new,
      Imports::Loaders::RecipeImage.new,
      Imports::Loaders::RecipeRate.new
    ].freeze

    def initialize
      @extractors = EXTRACTORS
      @loaders = LOADERS
    end

    def load_recipe_tables
      loaders.each(&:load)
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

    attr_reader :extractors, :loaders

    def parse_data(line, index)
      extractors.each do |extractor|
        extractor.prepare(JSON.parse(line), index)
      end
    end

    def insert_data
      extractors.each do |extractor|
        run_insert_query(extractor)
      end
    end

    def run_insert_query(extractor)
      query = extractor.insert_query % extractor.rows.join(",\n")
      query = ActiveRecord::Base.send(:sanitize_sql_array, [query, extractor.values])
      ActiveRecord::Base.connection.execute(query)

      extractor.rows = []
      extractor.values = {}
    end

    def database_cleanup
      extractors.each do |extractor|
        ActiveRecord::Base.connection.execute(extractor.drop_query)
      end
    end

    def database_setup
      extractors.each do |extractor|
        ActiveRecord::Base.connection.execute(extractor.create_query)
      end
    end
  end
end
