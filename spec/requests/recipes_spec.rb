# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:recipes) { create_list(:recipe, 2) }
  let(:recipe) { recipes.first }
  let(:recipes_json) do
    RecipeSerializer.new(recipes).serializable_hash.to_json
  end
  let(:recipe_json) do
    RecipeSerializer.new(recipe).serializable_hash.to_json
  end

  before do
    recipes_json
    recipe_json
  end

  context 'GET /index' do
    it 'renders a successful response' do
      get recipes_url, as: :json
      expect(response).to be_successful
      expect(response.body).to eq(recipes_json)
    end
  end
end
