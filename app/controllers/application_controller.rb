class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #show
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #create new recipe
  get '/recipes/new' do
    erb :new
  end

  #save new recipe
  post '/recipes' do
    @recipe = Recipe.create(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    redirect to "/recipes/#{@recipe.id}"
  end

  #view a recipe
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #load edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    erb :delete
  end
end
