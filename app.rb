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
  if Ingredient.exists?(name) == false
    new_ingredient = Ingredient.create({name: name})
    @recipe.ingredients.push(new_ingredient)
  else
    found_ingredient = Ingredient.find_by_name(name)
    if Ingredient.find_by_name(found_ingredient.name()) == found_ingredient
      @recipe.ingredients.push(found_ingredient)
    end
  end
  redirect to ('/recipes/' + @recipe.id().to_s)
end

delete('/recipes/:id') do
  recipe = Recipe.find(params['id'].to_i)
  recipe.destroy()
  redirect to('/')
end

delete('/ingredients/:id') do
  ingredient = Ingredient.find(params['id'].to_i)
  ingredient.destroy()
  redirect to('/')
end
