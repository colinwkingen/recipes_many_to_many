require('spec_helper')

describe(Recipe) do
  it "has many ingredients" do
    ingredient1 =Ingredient.create({:name => "Parsley"})
    ingredient2 =Ingredient.create({:name => "Turtles"})
    recipe = Recipe.create({:name => "Turtle Soup"})
    recipe.ingredients.push(ingredient1, ingredient2)
    expect(recipe.ingredients()).to(eq([ingredient1,ingredient2]))
  end

  it "has many categories" do
    category1 =Category.create({:name => "Dinner"})
    category2 =Category.create({:name => "Soups"})
    recipe = Recipe.create({:name => "Turtle Soup"})
    recipe.categories.push(category1, category2)
    expect(recipe.categories()).to(eq([category1,category2]))
  end

  it "can update its ingredients" do
    recipe = Recipe.create({:name => "Turtle Soup"})
    recipe.update({indgredients: 'Butter'})
    expect(recipe.ingredients()).to(eq('Butter'))
  end
end
