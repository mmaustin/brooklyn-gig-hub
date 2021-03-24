require 'pry'

class UsersController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.create(params)
        if @user.username.blank? || @user.email.blank? || @user.password.blank?
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
            redirect '/login'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        if @user == current_user
            erb :'users/show'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end