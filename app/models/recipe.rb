# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :author
  belongs_to :budget
  belongs_to :difficulty
  has_one :recipe_image
  has_one :recipe_rate
  has_one :recipe_author_tip
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :tags

  def self.find_by_ingredients(ingredient_ids, page, size)
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
      LIMIT
        :offset, :size
    SQL

    parameters = {
      ingredients: ingredient_ids,
      size: size,
      offset: (page.to_i - 1) * size.to_i
    }

    find_by_sql(sanitize_sql_for_assignment([query, parameters]))
  end
end
