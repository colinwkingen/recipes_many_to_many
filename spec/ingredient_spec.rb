require('spec_helper')

describe(Ingredient) do
  it "has many recipes" do
    recipe1 =Recipe.create({:name => "Meatloaf"})
    recipe2 =Recipe.create({:name => "Turtle Soup"})
    ingredient1 = Ingredient.create({:name => "Parsley", :recipe_ids => [recipe1.id(), recipe2.id()]})
    expect(ingredient1.recipes()).to(eq([recipe1,recipe2]))
  end
end
