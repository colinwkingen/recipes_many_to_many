class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)

  define_singleton_method(:exists?) do |name|
    result = false
    all_categories = Category.all()
    all_categories.each() do |category|
      if category.name() == name
        result = true
      end
    end
    result
  end

  define_singleton_method(:find_by_name) do |name|
    all_categories = Category.all()
    found_category = nil
    all_categories.each() do |category|
      if category.name() == name
        found_category = category
      end
    end
    found_category
  end
end
