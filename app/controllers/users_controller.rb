class UsersController < ApplicationController
  # Render the sign-up form view
  get '/users/signup' do
    erb :'/users/signup'
  end

  # Handle the POST request that is sent when a user hits 'submit' on the sign-up form
  # after submitting, it will redirect
  post '/users' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/users/home'
    else
      erb :'/error'
    end
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
end # end of class
