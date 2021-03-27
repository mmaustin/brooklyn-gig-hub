require 'pry'

class PlayersController < ApplicationController

    get '/players' do
        @players = Player.all
        if !logged_in?
            flash[:error] = "Please log in!"
            redirect '/login'
        else
            erb :'players/index'
        end
    end

    get '/players/new' do
        if !logged_in?
            flash[:error] = "Please log in!"
            redirect '/login'
        else
            erb :'players/new'
        end
    end

    post '/players' do
        @player = Player.new(params)
        if @player.name.blank? || @player.instrument.blank?
            flash[:error] = "You must fill in each field."
            redirect '/players/new'
        else
            @player.user = current_user
            @player.save
        end
        redirect "players/#{@player.id}"
    end

    get '/players/:id' do
        if !Player.find_by_id(params[:id])
            flash[:error] = "You entered a player who does not exist."
            redirect "/players"
        else
            @player = Player.find_by_id(params[:id])
            if @player.user == current_user
                erb :'players/show'
            else
                flash[:error] = "Please select one of your players."
                redirect '/players'
            end
        end
    end

    get '/players/:id/edit' do
        if !Player.find_by_id(params[:id])
            flash[:error] = "You entered a player who does not exist."
            redirect "/players"
        else
            @player = Player.find_by_id(params[:id])
            if @player.user == current_user
                erb :'players/edit'
            else
                flash[:error] = "You can only edit one of your own players."
                redirect '/players'
            end
        end
    end

    patch '/players/:id' do
        @player = Player.find_by_id(params[:id])
        if @player.user == current_user && params[:name] != "" && params[:instrument] != ""
            @player.update(name: params[:name], instrument: params[:instrument])
            redirect "/players/#{@player.id}"
        else
            flash[:error] = "Please try again. Fill in all fields."
            redirect "/players/#{@player.id}/edit"
        end
    end

    delete '/players/:id' do
        @player = Player.find_by(id: params[:id])
        if @player.user == current_user
            @player.destroy
                if Player.all.size == 0
                    redirect '/players/new'
                else
                    redirect '/players'
                end
        else
            redirect '/players'
        end
    end

end