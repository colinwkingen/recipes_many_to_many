require('spec_helper')

describe(Category) do
  describe('#recipes') do
    it "has many recipes" do
      category1 = Category.create({:name => "Dinner"})
      recipe1 =Recipe.create({:name => "Meatloaf"})
      recipe2 =Recipe.create({:name => "Turtle Soup"})
      category1.recipes.push(recipe1, recipe2)
      expect(category1.recipes()).to(eq([recipe1,recipe2]))
    end
  end
end
