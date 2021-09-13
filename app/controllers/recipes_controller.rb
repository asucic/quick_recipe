# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    render json: fetch_recepies
  end

  private
    def fetch_recepies
      if params[:filter].nil? || params[:filter][:ingredients].nil?
        Recipe.all
      else
        Recipe.find_by_ingredients(params[:filter][:ingredients].split(','))
      end
    end
end
