class BreedsController < ApplicationController
  # GET /breeds
  def index
    @breeds = Breed.page(params[:page]).per(9) # breeds per page
  end

  # GET /breeds/:id
  def show
    @breed = Breed.find(params[:id])
  end
end
