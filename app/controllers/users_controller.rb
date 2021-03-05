class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/articles'
        else
            erb :"users/signup"
        end
    end

    post '/signup' do
        user = User.new(params)

        if user.username.blank? || user.email.blank? || user.name.blank? || user.password.blank?
            flash[:error] = "All fields must be filled out. Please try again."
            redirect '/signup'
        elsif User.find_by_email(params[:email]) || User.find_by_username(params[:username])
            flash[:error] = "This account already exists."
            redirect '/login'
        else
            user.save
            session[:user_id] = user.id
            redirect '/articles'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/articles'
        else
            erb :"users/login"
        end
    end

    post '/login' do
        user = User.find_by_username(params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/articles'
        else
            flash[:error] = "Invalid login"
            redirect '/login'
        end
    end
    
    get '/logout' do
        session.clear
        redirect '/login'
    end
    
end