# frozen_string_literal: true

class Recipe < ApplicationRecord
  paginates_per 2

  belongs_to :author
  belongs_to :budget
  belongs_to :difficulty
  has_one :recipe_image
  has_one :recipe_rate
  has_one :recipe_author_tip
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :tags

  def self.find_by_ingredients(ingredient_ids)
    query = <<-SQL
      SELECT
        r.*,
        COUNT(ai.id) count_ai,
        COUNT(i.id) count_i
      FROM
        recipes r
        JOIN ingredients_recipes ir
          ON r.id = ir.recipe_id
        JOIN ingredients ai
          ON ir.ingredient_id = ai.id
        LEFT JOIN ingredients i
          ON ir.ingredient_id = i.id
          AND i.id IN (:ingredients)
      GROUP BY
        r.id
      HAVING
        count_ai = count_i
    SQL

    connection.execute(
      sanitize_sql_for_assignment([query, { ingredients: ingredient_ids }])
    )
  end
end
