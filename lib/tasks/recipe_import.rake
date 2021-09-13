# frozen_string_literal: true

require_relative '../../app/services/imports/recipe_import'

namespace :db do
  desc 'Import recipes to database'

  task recipe_import: :environment do
    import = Services::Imports::RecipeImport.new

    puts 'Reading recipes'
    File.readlines('storage/recipes.json').each do |line|
      import.parse_and_store(JSON.parse(line))
    end

    puts "Importing #{import.relations['authors'].count} authors"
    Author.import import.relations['authors'].values

    puts "Importing #{import.relations['budgets'].count} budgets"
    Budget.import import.relations['budgets'].values

    puts "Importing #{import.relations['difficulties'].count} difficulties"
    Difficulty.import import.relations['difficulties'].values

    puts "Importing #{import.relations['ingredients'].count} ingredients"
    Ingredient.import import.relations['ingredients'].values

    puts "Importing #{import.relations['tags'].count} tags"
    Tag.import import.relations['tags'].values

    # Bulk insert with relations only works on PostgreSQL
    # https://github.com/zdennis/activerecord-import
    puts "Importing #{import.recipes.count} recipes"
    import.recipes.each(&:save)

    puts "Importing #{import.relations['author_tip'].count} author_tips"
    import.relations['author_tip'].each(&:save)

    puts "Importing #{import.relations['image'].count} images"
    import.relations['image'].each(&:save)

    puts "Importing #{import.relations['rate'].count} rates"
    import.relations['rate'].each(&:save)

    puts 'Import completed!'
  end
end
