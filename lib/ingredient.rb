class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)

  define_singleton_method(:exists?) do |name|
    result = false
    all_ingredients = Ingredient.all()
    all_ingredients.each() do |ingredient|
      if ingredient.name() == name
        result = true
      end
    end
    result
  end

  define_singleton_method(:find_by_name) do |name|
    all_ingredients = Ingredient.all()
    found_ingredient = nil
    all_ingredients.each() do |ingredient|
      if ingredient.name() == name
        found_ingredient = ingredient
      end
    end
    found_ingredient
  end
end
