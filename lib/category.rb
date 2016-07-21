class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates :name, length: {minimum: 3}
  before_save(:format_input)

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

private
  define_method(:format_input) do
    self.name=(name().capitalize())
  end
end
