# frozen_string_literal: true

class IngredientsController < ApplicationController
  def index
    render json: fetch_ingredients
  end

  private

  def fetch_ingredients
    page = params[:page] || 1
    size = params[:page_size] || Kaminari.config.default_per_page

    if params[:filter].nil? || params[:filter][:name].nil?
      Ingredient.page(page).per(size)
    else
      name = params[:filter][:name]
      Ingredient.where('name LIKE ?', "#{name}%").order('name').page(page).per(size)
    end
  end
end
