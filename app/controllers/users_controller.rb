require 'pry'

class UsersController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.create(params)
        if @user.username.blank? || @user.email.blank? || @user.password.blank?
            #redirect '/signup'
            flash[:error] = "You must fill in all entries!"
            redirect '/signup'
        else
            session[:user_id] = @user.id
        end
        redirect '/gigs'
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by_username(params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/gigs'
        else
            flash[:error] = "Retry log in!"
            redirect '/login'
        end
    end

    get '/users' do
        @users = User.all 
        if !logged_in?
            flash[:error] = "You are not logged in!"
            redirect '/login'
        else
            erb :'users/index'
        end
    end

    get '/users/:id' do
        @user = User.find_by_id(params[:id])
        if @user == current_user
            erb :'users/show'
        else
            flash[:error] = "Please select your band."
            redirect '/users'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end
