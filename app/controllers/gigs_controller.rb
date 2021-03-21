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
        @gig = Gig.find_by_id(params[:id])
        erb :'gigs/show'
    end


end