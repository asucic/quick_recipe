# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'search#index'

  resources :ingredients, only: [:index]
  resources :recipes, only: [:index]
end
