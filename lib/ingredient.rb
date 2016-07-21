class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates :name, length: {minimum: 3}
  before_create(:format_input)

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

private
  define_method(:format_input) do
    self.name=(name().capitalize())
  end
end
