require 'pry'

class UsersController < ApplicationController
    
    get '/signup' do
        erb :'users/signup'
    end

    get '/main' do
        @user = User.find_by_id(session[:user_id])
        erb :'users/main'
    end

    post '/signup' do
        #binding.pry
        @user = User.create(params)
        if @user.username.blank? || @user.email.blank? || @user.password.blank?
            redirect '/signup'
        else
            session[:user_id] = @user.id
        #binding.pry
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
        #binding.pry
        @user = User.find_by(id: params[:id])
        erb :'users/show'
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end