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
end # end of Class
