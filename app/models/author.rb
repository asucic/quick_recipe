# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :recipes
end
