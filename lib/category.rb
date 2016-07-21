class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates :name, length: {minimum: 3}
  before_save(:format_input)

private
  define_method(:format_input) do
    self.name=(name().capitalize())
  end
end
