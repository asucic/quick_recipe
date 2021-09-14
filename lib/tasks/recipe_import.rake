# frozen_string_literal: true

module Tasks
  class RecipeImport
    include Rake::DSL

    RECIPES_FILEPATH = Rails.root.join('lib', 'tasks', 'recipes.json')

    def initialize
      namespace :recipe_import do
        desc 'Imports recipes to database'
        task run: :environment do
          import = Imports::RecipeImport.new

          puts 'Importing started...'
          import.bulk_import_recipe File.foreach(RECIPES_FILEPATH)
          import.load_recipe_tables

          puts 'Finished'
        end
      end
    end
  end
end

Tasks::RecipeImport.new
