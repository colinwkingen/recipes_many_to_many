require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get('/') do
  @recipes = Recipe.all().order("rating desc")
  @ingredients = Ingredient.all()
  @categories = Category.all()
  erb(:index)
end

post('/recipes') do
  name = params.fetch('name')
  if name.length >= 3
    @new_recipe = Recipe.create({name: name, rating: 0})
    redirect to('/')
  else
    redirect to('/')
  end
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

get('/categories/:id') do
  @category = Category.find(params['id'].to_i)
  @recipes = @category.recipes()
  erb(:category)
end

post('/recipes/:id/rating') do
  @recipe = Recipe.find(params['id'].to_i)
  rating = params['rating'].to_i
  @recipe.update({rating: rating})
  redirect to ('/recipes/' + @recipe.id().to_s)
end


post('/recipes/:recipe_id/ingredients/:ingredient_id/remove') do
  ingredient = Ingredient.find(params['ingredient_id'])
  @recipe = Recipe.find(params['recipe_id'])
  @recipe.ingredients.delete(ingredient)
  redirect to ('/recipes/' + @recipe.id().to_s)
end

post('/recipes/:recipe_id/categories/:category_id/remove') do
  category = Category.find(params['category_id'])
  @recipe = Recipe.find(params['recipe_id'])
  @recipe.categories.delete(category)
  redirect to ('/recipes/' + @recipe.id().to_s)
end


post('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params['id'].to_i)
  ingredient = params['name'].capitalize()
  new_ingredient = Ingredient.find_or_create_by(name: ingredient)
  if Ingredient.find_by_name(ingredient) != nil && Ingredient.find_by_name(ingredient).id == new_ingredient.id()
    if @recipe.ingredients.length != 0
      found = nil
      @recipe.ingredients.each do |ingredient|
        if ingredient.name() == new_ingredient.name()
          found = true
        end
      end
      if found != true
        @recipe.ingredients.push(new_ingredient)
      end
    else
      @recipe.ingredients.push(new_ingredient)
    end
    redirect to ('/recipes/' + @recipe.id().to_s)
  else
    redirect to ('/recipes/' + @recipe.id().to_s)
  end
end


post('/recipes/:id/categories') do
  @recipe = Recipe.find(params['id'].to_i)
  category = params['category'].capitalize()
  new_category = Category.find_or_create_by(name: category)
  if Category.find_by_name(category) != nil && Category.find_by_name(category).id == new_category.id()
    if @recipe.categories.length != 0
      found = nil
      @recipe.categories.each do |category|
        if category.name() == new_category.name()
          found = true
        end
      end
      if found != true
        @recipe.categories.push(new_category)
      end
    else
      @recipe.categories.push(new_category)
    end
    redirect to ('/recipes/' + @recipe.id().to_s)
  else
    redirect to ('/recipes/' + @recipe.id().to_s)
  end
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

delete('/categories/:id') do
  category = Category.find(params['id'].to_i)
  category.destroy()
  redirect to('/')
end

get('/recipes/:id/edit') do
  @recipe = Recipe.find(params['id'].to_i)
  erb(:recipe_title_edit)
end

patch('/recipes/:id') do
  name = params['name']
  instructions = params['instructions']
  @recipe = Recipe.find(params['id'])
  @recipe.update({name: name, instruction: instructions})
  redirect('/recipes/' + @recipe.id.to_s)
end
