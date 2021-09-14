# frozen_string_literal: true

require_relative '../../app/services/imports/recipe_import'

namespace :db do
  desc 'Import recipes to database'

  task recipe_import: :environment do
    import = Services::Imports::RecipeImport.new

    import.bulk_import_recipe File.foreach('storage/recipes.json')
    import.load_recipe_tables
  end
end
