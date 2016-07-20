require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/') do
  @recipes = Recipe.all()
  @ingredients = Ingredient.all()
  @categories = Category.all()
  erb(:index)
end

post('/recipes') do
  name = params.fetch('name')
  @new_recipe = Recipe.create({name: name})
  redirect to('/')
end

get('/recipes/:id') do
  @recipe = Recipe.find(params['id'].to_i)
  erb(:recipe)
end

get('/ingredients/:id') do
  @ingredient = Ingredient.find(params['id'].to_i)
  @recipes = @ingredient.recipes()
  erb(:ingredient)
end

post('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params['id'].to_i)
  name = params['name']
  all_ingredients = Ingredient.all()
  all_ingredients.each() do |ingredient|
    if ingredient.name() == name
      @recipe.update({ingredient_ids => [ingredient.id()]})
      # @recipe.ingredients.push(ingredient)
      redirect to ('/recipes/' + @recipe.id().to_s)
    else
      new_ingredient = Ingredient.create({name: name})
      @recipe.ingredients.push(new_ingredient)
      redirect to ('/recipes/' + @recipe.id().to_s)
    end
  end
end

# patch('/recipes/:id') do
#   @recipe = Recipe.find(params['id'].to_i)
#   ingredients = params['ingredients']
#   @recipe.update({ingredients: ingredients})
#   redirect to ('/')
# end
