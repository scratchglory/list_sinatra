require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'this_secret'
  end

  get '/' do
    # erb :welcome
    erb :index
  end

  # Render the sign-up form view
  get '/users/signup' do
    erb :'/users/signup'
  end

  # Handle the POST request that is sent when a user hits 'submit' on the sign-up form
  # after submitting, it will redirect
  post '/users' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect '/users/home'
  end

  # Render login form
  get '/users/login' do
    erb :'users/login'
  end

  # Receive the POST request that gets sent when a user hits 'log in' on the login form
  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/users/home'
    else
      redirect '/users/login'
    end
  end

  # Render the user's homepage view
  get '/users/home' do
    # binding.pry
    @items = Item.where(user_id: session[:user_id])
    @user = User.find(session[:user_id])
    erb :'users/home'
  end

  # Logging the user out by clearing the session hash
  get '/logout' do
    session.clear
    redirect '/'
  end

  # To read all items
  get '/items' do
    @items = Item.where(user_id: session[:user_id])
    erb :'items/index'
  end

  # creating a new item
  get '/items/new' do
    erb :'items/new'
  end

  # Read the list, job not to display to user (only do something)
  post '/items' do
    @item = Item.create(params)
    @item.user_id = session[:user_id]
    # Needs to be saved for user_id
    @item.save
    redirect "/items/#{@item.id}"
  end

  # To show individual item
  get '/items/:id' do
    @item = Item.find(params[:id])
    erb :'items/show'
  end

  get '/items/edit' do
    @items = Item.where(user_id: session[:user_id])
    erb :'items/list'
  end

  get '/items/:id/edit' do
    @item = Item.find(params[:id])
    erb :'items/edit'
  end

  # Edit an item
  patch '/items/:id' do
    @item = Item.find(params[:id])
    @item.update(name: params[:name], quantity: params[:quantity])
    redirect "/items/#{@item.id}"
  end

  # Delete an item
  delete '/items/:id' do
    @item = Item.find(params[:id])
    @item.destroy

    redirect '/users/home'
  end


end # end of Class
