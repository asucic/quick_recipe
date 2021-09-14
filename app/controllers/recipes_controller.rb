# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_pagination

  def index
    render json: fetch_recepies.to_json(include: Serializers::Recipe.new.relations)
  end

  private

  def fetch_recepies
    if params[:filter]&.[](:ingredients).nil?
      Recipe.page(@page).per(@size)
    else
      Recipe.find_by_ingredients(params[:filter][:ingredients].split(','), @page, @size)
    end
  end

  def set_pagination
    @page = params[:page] || 1
    @size = params[:page_size] || Kaminari.config.default_per_page
  end
end
