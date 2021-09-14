# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ingredients', type: :request do
  let(:ingredients) { create_list(:ingredient, 2) }
  let(:ingredient) { ingredients.first }
  let(:ingredients_json) do
    IngredientSerializer.new(ingredients).serializable_hash.to_json
  end
  let(:ingredient_json) do
    IngredientSerializer.new(ingredient).serializable_hash.to_json
  end

  before do
    ingredients_json
    ingredient_json
  end

  context 'GET /index' do
    it 'renders a successful response' do
      get ingredients_url, as: :json
      expect(response).to be_successful
      expect(response.body).to eq(ingredients_json)
    end
  end
end
