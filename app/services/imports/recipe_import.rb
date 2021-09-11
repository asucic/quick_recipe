module RecipeImport
  @@authors = Hash.new
  @@budgets = Hash.new
  @@difficulties = Hash.new
  @@tags = Hash.new
  @@ingredients = Hash.new

  def self.authors
    @@authors
  end

  def self.budgets
    @@budgets
  end

  def self.difficulties
    @@difficulties
  end

  def self.tags
    @@tags
  end

  def self.ingredients
    @@ingredients
  end

  def load_author(value)
    value = value.titleize
    key = value.parameterize.underscore.to_sym
    @@authors.store(key, @@authors[key] || Author.new(name: value))
  end

  def load_budget(value)
    value = value.titleize
    key = value.parameterize.underscore.to_sym
    @@budgets.store(key, @@budgets[key] || Budget.new(name: value))
  end

  def load_difficulty(value)
    value = value.titleize
    key = value.parameterize.underscore.to_sym
    @@difficulties.store(key, @@difficulties[key] || Difficulty.new(name: value))
  end

  def load_tags(values)
    tags = []

    values.each do |value|
      value = value.titleize
      key = value.parameterize.underscore.to_sym
      tags << @@tags.store(key, @@tags[key] || Tag.new(name: value))
    end

    tags
  end

  def load_ingredients(values)
    ingredients = []

    values.each do |value|
      value = value.titleize
      key = value.parameterize.underscore.to_sym
      ingredients << @@ingredients.store(key, @@ingredients[key] || Ingredient.new(name: value))
    end

    ingredients
  end
end
