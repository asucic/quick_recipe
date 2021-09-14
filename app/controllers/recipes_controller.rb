# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    relationships = {
      'author' => { only: %w[id name] },
      'budget' => { only: %w[id name] },
      'difficulty' => { only: %w[id name] },
      'ingredients' => { only: %w[id name] },
      'recipe_author_tip' => { only: %w[id name] },
      'recipe_image' => { only: %w[id name] },
      'recipe_rate' => { only: %w[id name] },
      'tags' => { only: %w[id name] }
    }

    render json: fetch_recepies.to_json(include: relationships)
  end

  private

  def fetch_recepies
    page = params[:page] || 1
    size = params[:page_size] || Kaminari.config.default_per_page

    if params[:filter].nil? || params[:filter][:ingredients].nil?
      Recipe.page(page).per(size)
    else
      Recipe.find_by_ingredients(params[:filter][:ingredients].split(','), page, size)
    end
  end
end
