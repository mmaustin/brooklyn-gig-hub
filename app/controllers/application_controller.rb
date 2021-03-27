require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do

    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) #gets the current user
    end

    def logged_in?
      !!current_user #confirms that there is a current user
    end

  end

end
