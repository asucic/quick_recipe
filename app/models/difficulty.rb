# frozen_string_literal: true

class Difficulty < ApplicationRecord
  has_many :recipes
end
