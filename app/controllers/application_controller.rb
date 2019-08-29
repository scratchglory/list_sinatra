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
    @items = Item.all
    erb :'items/index'
  end

  # creating a new item
  get '/items/new' do
    erb :'items/new'
  end

  # To show individual item
  get '/items/:name' do
    @item = Item.find(params[:name])

    erb :'items/show'
    # binding.pry
  end

  # Read the list, job not to display to user (only do something)
  post '/items' do
    # binding.pry
    @item = Item.create(params)
    redirect "/items/#{@item.id}"
  end
end # end of Class
