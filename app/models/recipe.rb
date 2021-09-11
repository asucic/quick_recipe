class Recipe < ApplicationRecord
  belongs_to :author
  belongs_to :budget
  belongs_to :difficulty
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :tags
end
