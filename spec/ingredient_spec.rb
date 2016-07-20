require('spec_helper')

describe(Ingredient) do
  it "has many recipes" do
    recipe1 =Recipe.create({:name => "Meatloaf"})
    recipe2 =Recipe.create({:name => "Turtle Soup"})
    ingredient1 = Ingredient.create({:name => "Parsley", :recipe_ids => [recipe1.id(), recipe2.id()]})
    expect(ingredient1.recipes()).to(eq([recipe1,recipe2]))
  end

  describe(".exists?") do
    it('tells you whether an ingredient has already been created') do
      ingredient1 =Ingredient.create({:name => "Parsley"})
      expect(Ingredient.exists?('Parsley')).to(eq(true))
    end
  end

  describe(".find_by_name") do
    it('returns an ingredient if it has the same name') do
      ingredient1 =Ingredient.create({:name => "Parsley"})
      expect(Ingredient.find_by_name('Parsley')).to(eq(ingredient1))
    end
  end
end
# it "will not create two objects with the same name" do
#   ingredient1 =Ingredient.create({:name => "Parsley"})
#   ingredient2 =Ingredient.create({:name => "Parsley"})
#   expect(Ingredient.all()).to(eq([ingredient1]))
# end
