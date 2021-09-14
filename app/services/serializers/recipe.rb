# frozen_string_literal: true

module Serializers
  class Recipe
    RELATIONS = {
      author: Author.new,
      budget: Budget.new,
      difficulty: Difficulty.new,
      ingredients: Ingredient.new,
      recipe_author_tip: RecipeAuthorTip.new,
      recipe_image: RecipeImage.new,
      recipe_rate: RecipeRate.new,
      tags: Tag.new
    }.freeze

    def relations
      relations = {}
      RELATIONS.each do |relation, serializer|
        relations[relation] = { only: serializer.attributes }
      end
      relations
    end
  end
end
