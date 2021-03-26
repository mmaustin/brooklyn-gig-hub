require 'pry'

class GigsController < ApplicationController

    get '/gigs' do
        @gigs = Gig.all 
        if !logged_in?
            flash[:error] = "Please log in!"
            redirect '/login'
        else
            erb :'gigs/index'
        end
    end

    get '/gigs/new' do
        if !logged_in?
            flash[:error] = "Please log in!"
            redirect '/login'
        else
            erb :'gigs/new'
        end
    end

    post '/gigs' do
        @gig = Gig.new(params)
        if @gig.venue.blank? || @gig.date.blank? || @gig.time.blank?
            flash[:error] = "You must fill in each field."
            redirect '/gigs/new'
        else
            @gig.user = current_user
            @gig.save
        end
        redirect "gigs/#{@gig.id}"
    end

    get '/gigs/:id' do
        @gig = Gig.find_by_id(params[:id])
        if @gig.user == current_user
            erb :'gigs/show'
        else
            flash[:error] = "Please select one of your gigs."
            redirect '/gigs'
        end
    end

    get '/gigs/:id/edit' do
        @gig = Gig.find_by_id(params[:id])
        if @gig.user == current_user
            erb :'gigs/edit'
        else
            flash[:error] = "You can only edit one of your own gigs."
            redirect '/gigs'
        end
    end


    patch '/gigs/:id' do
        @gig = Gig.find_by_id(params[:id])
        if @gig.user == current_user && params[:venue] != "" && params[:date] != "" && params[:time] != ""
            @gig.update(venue: params[:venue], date: params[:date], time: params[:time])
            redirect "/gigs/#{@gig.id}"
        else
            flash[:error] = "Please try to edit your gig again."
            redirect "/gigs/#{@gig.id}/edit"
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
            redirect '/gigs'
        end
    end

end