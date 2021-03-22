require 'pry'

class GigsController < ApplicationController

    get '/gigs' do
        @gigs = Gig.all 
        if !logged_in?
            redirect '/login'
        else
            erb :'gigs/index'
        end
    end

    get '/gigs/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'gigs/new'
        end
    end

    post '/gigs' do
        #binding.pry
        @gig = Gig.new(params)
        if @gig.venue.blank? || @gig.date.blank? || @gig.time.blank?
            redirect '/gigs/new'
        else
            @gig.user = current_user
            @gig.save
        end
        #redirect '/gigs'
        redirect "gigs/#{@gig.id}"
    end

    get '/gigs/:id' do
        #binding.pry
        if logged_in?
            @gig = Gig.find_by_id(params[:id])
            erb :'gigs/show'
        else
            redirect '/login'
        end
    end

    get '/gigs/:id/edit' do
        if logged_in?
            @gig = Gig.find_by_id(params[:id])
            erb :'gigs/edit'
        else
            redirect '/login'
        end
    end


    patch '/gigs/:id' do
        @gig = Gig.find_by_id(params[:id])
        if @gig.user == current_user && params[:venue] != nil && params[:date] != nil && params[:time] != nil
            @gig.update(venue: params[:venue], date: params[:date], time: params[:time])
            redirect "/gigs/#{@gig.id}"
        else
            redirect 'login'
        end
    end

    delete '/gigs/:id' do
        @gig = Gig.find_by(id: params[:id])
        if @gig.user == current_user
            @gig.destroy
                if Gig.all.size == 0
                    redirect '/gigs/new'
                else
                    redirect '/gigs'
                end
        else
            redirect 'login'
        end
    end

end