class LandmarksController < ApplicationController

    get '/landmarks' do 
    @landmarks = Landmark.all

    erb :'/landmarks/index'
  end

  get '/landmarks/new' do 
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do 
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

# name, figure_id , year_completed 
  post '/landmarks' do 
    # binding.pry
    @landmark = Landmark.create(name: params[:landmark_name], year_completed: params[:landmark_year_completed])
  redirect to "/landmarks/#{@landmark.id}"
  end

   get '/landmarks/:id/edit' do 
    @landmark = Landmark.find_by_id(params[:id])
 
    erb :'/landmarks/edit'
  end

  post '/landmarks/:id' do 
   @landmark = Landmark.find_by_id(params[:id])
   @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
   redirect to "/landmarks/#{@landmark.id}"
  end


end




  # allows you to view form to create a new landmark (FAILED - 1)
  # allows you to create a new landmark (FAILED - 2)
  # allows you to list all landmarks (FAILED - 3)
  # allows you to see a single landmark (FAILED - 4)
  # allows you to view form edit a single landmark (FAILED - 5)
  # allows you to edit a single landmark (FAILED - 6)
