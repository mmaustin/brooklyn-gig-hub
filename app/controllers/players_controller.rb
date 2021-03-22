require 'pry'

class PlayersController < ApplicationController

    get '/players' do
        @players = Player.all
        erb :'players/index'
    end

    get '/players/new' do
        erb :'players/new'
    end

    post '/players' do
        #binding.pry
        @player = Player.new(params)
        if @player.name.blank? || @player.instrument.blank?
            redirect '/players/new'
        else
            @player.user = User.all.last
            @player.save
        end
        redirect '/players'
        #redirect "players/#{@player.id}"
    end

    get '/players/:id' do
        @player = Player.find_by_id(params[:id])
        erb :'players/show'
    end

end