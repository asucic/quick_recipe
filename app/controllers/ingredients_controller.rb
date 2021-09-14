# frozen_string_literal: true

class IngredientsController < ApplicationController
  before_action :set_pagination

  def index
    render json: fetch_ingredients.to_json
  end

  private

  def fetch_ingredients
    if params[:filter]&.[](:name).nil?
      Ingredient.page(@page).per(@size)
    else
      Ingredient.where('name LIKE ?', "#{params[:filter][:name]}%").order('name').page(@page).per(@size)
    end
  end

  def set_pagination
    @page = params[:page] || 1
    @size = params[:page_size] || Kaminari.config.default_per_page
  end
end
