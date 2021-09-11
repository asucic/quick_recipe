require_relative "../../app/services/imports/recipe_import"
include RecipeImport

namespace :db do
  desc 'Import recipes to database'

  task recipe_import: :environment do
    import = RecipeImport
    recipes = []

    puts 'Reading recipes'
    File.readlines('storage/recipes.json').each do |line|
      values = JSON.parse(line)
      values['author'] = import.load_author values['author']
      values['budget'] = import.load_budget values['budget']
      values['difficulty'] = import.load_difficulty values['difficulty']
      values['ingredients'] = import.load_ingredients values['ingredients']
      values['tags'] = import.load_tags values['tags']
      recipes << Recipe.new(values)
    end

    puts 'Importing authors'
    Author.import import.authors.values

    puts 'Importing budgets'
    Budget.import import.budgets.values

    puts 'Importing difficulties'
    Difficulty.import import.difficulties.values

    puts 'Importing ingredients'
    Ingredient.import import.ingredients.values

    puts 'Importing tags'
    Tag.import import.tags.values

    puts 'Importing recipes'
    recipes.each do |recipe|
      recipe.save
    end

    puts 'Import completed!'
  end
end
