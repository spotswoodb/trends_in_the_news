require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get "/" do
    erb :index
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  # archive route where users can view their stored articles
end
