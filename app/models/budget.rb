# frozen_string_literal: true

class Budget < ApplicationRecord
  has_many :recipes
end
