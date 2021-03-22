require 'pry'

class GigsController < ApplicationController

    get '/gigs' do
        @gigs = Gig.all 
        erb :'gigs/index'
    end

    get '/gigs/new' do
        erb :'gigs/new'
    end

    post '/gigs' do
        #binding.pry
        @gig = Gig.new(params)
        if @gig.venue.blank? || @gig.date.blank? || @gig.time.blank?
            redirect '/gigs/new'
        else
            @gig.user = User.all.last
            @gig.save
        end
        #redirect '/gigs'
        redirect "gigs/#{@gig.id}"
    end

    get '/gigs/:id' do
        #binding.pry
        @gig = Gig.find_by_id(params[:id])
        erb :'gigs/show'
    end

    get '/gigs/:id/edit' do
        @gig = Gig.find_by_id(params[:id])
        erb :'gigs/edit'
    end


    post '/gigs/:id' do
        @gig = Gig.find_by_id(params[:id])
        @gig.update(venue: params[:venue], date: params[:date], time: params[:time])
        redirect "/gigs/#{@gig.id}"
    end

    post '/gigs/gigs/:id' do
        @gig = Gig.find_by(id: params[:id])
        @gig.destroy
        if Gig.all.size == 0
            redirect '/gigs/new'
        else
            redirect '/gigs'
        end
    end

end