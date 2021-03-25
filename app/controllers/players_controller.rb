require 'pry'

class PlayersController < ApplicationController

    get '/players' do
        @players = Player.all
        if !logged_in?
            redirect '/login'
        else
            erb :'players/index'
        end
    end

    get '/players/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'players/new'
        end
    end

    post '/players' do
        @player = Player.new(params)
        if @player.name.blank? || @player.instrument.blank?
            redirect '/players/new'
        else
            @player.user = current_user
            @player.save
        end
        redirect "players/#{@player.id}"
    end

    get '/players/:id' do
        @player = Player.find_by_id(params[:id])
        if @player.user == current_user
            erb :'players/show'
        else
            redirect '/players'
        end
    end

    get '/players/:id/edit' do
        @player = Player.find_by_id(params[:id])
        if @player.user == current_user
            erb :'players/edit'
        else
            redirect '/players'
        end
    end

    patch '/players/:id' do
        @player = Player.find_by_id(params[:id])
        if @player.user == current_user && params[:name] != "" && params[:instrument] != ""
            @player.update(name: params[:name], instrument: params[:instrument])
            redirect "/players/#{@player.id}"
        else
            redirect '/players'
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