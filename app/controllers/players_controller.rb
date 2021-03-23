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
        #binding.pry
        @player = Player.new(params)
        if @player.name.blank? || @player.instrument.blank?
            redirect '/players/new'
        else
            @player.user = current_user
            @player.save
        end
        #redirect '/players'
        redirect "players/#{@player.id}"
    end

    get '/players/:id' do
        if logged_in?
            @player = Player.find_by_id(params[:id])
            erb :'players/show'
        else
            redirect '/login'
        end
    end

    get '/players/:id/edit' do
        if logged_in?
            @player = Player.find_by_id(params[:id])
            erb :'players/edit'
        else
            redirect '/login'
        end
    end

    patch '/players/:id' do
        @player = Player.find_by_id(params[:id])
        @player.update(name: params[:name], instrument: params[:instrument])
        redirect "/players/#{@player.id}"
    end

    delete "/players/:id" do
        @player = Player.find_by_id(params[:id])
        @player.destroy
        redirect '/players'
    end

end