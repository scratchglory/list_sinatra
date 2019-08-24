require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :welcome
  end

  # Render the sign-up form view
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # Handle the POST request that is sent when a user hits 'submit' on the sign-up form
  # after submitting, it will redirect
  post '/registrations' do
    @user =
      User.new(
        name: params['name'],
        email: params['email'],
        password: params['password']
      )
    @user.save
    session[:user_id] = @user.id

    redirect '/users/home'
  end

  # Render login form
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # Receive the POST request that gets sent when a user hits 'submit' on the login form
  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  # Logging the user out by clearing the session hash
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  # Render the user's homepage view
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

  get '/users' do
  end
end