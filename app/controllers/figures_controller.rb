class FiguresController < ApplicationController

  get '/figures' do 
    @figures = Figure.all

    erb :'/figures/index'
  end

  get '/figures/new' do 
    erb :'/figures/new'
  end

   get '/figures/:id' do 
    @figure = Figure.find_by_id(params[:id])

    erb :'/figures/show'
  end

  # this route gets params to create a new figure and give it 
  #exisiting or new landmarks/titles
  post '/figures' do 
  # binding.pry

  @figure = Figure.create(name: params[:figure_name]) 

  #add the figures and titles that are checked, if any 
  if params.keys.include?("figure")
    
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
      @figure.landmarks << Landmark.find(id)
      end
    end

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
      @figure.titles << Title.find(id)
      end
    end
  
  end
    #add the new landmark and title to the @figure if anything is given
    if params[:new_landmark]
      @figure.landmarks << Landmark.create(name: params[:new_landmark])
    end

    if params[:new_title]
      @figure.titles << Title.create(name: params[:new_title])
    end

    @figure.save 
  
  redirect "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do 
    @figure = Figure.find(params[:id])

    # if they updated the name - the key will be here
      if !params[:figure][:name].empty?
        @figure.name = params[:figure][:name]
      end

    # clear this incase updates are made
    @figure.landmarks.clear
    @figure.titles.clear 
    
        if params[:figure][:landmark_ids]
          params[:figure][:landmark_ids].each do |id|
          @figure.landmarks << Landmark.find(id)
          end
        end

        if params[:figure][:title_ids]
          params[:figure][:title_ids].each do |id|
          @figure.titles << Title.find(id)
          end
        end

    #edit the new landmark and title to the @figure if anything is given
    if !params[:new_landmark].empty?
      @figure.landmarks << Landmark.create(name: params[:new_landmark])
    end

    if !params[:new_title].empty?
      @figure.titles << Title.create(name: params[:new_title])
    end

    @figure.save 
  
    redirect "figures/#{@figure.id}"
  end # end of the post edit call 

end


 # rspec spec/controllers/figures_controller_spec.rb 