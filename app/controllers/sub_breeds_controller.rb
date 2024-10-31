class SubBreedsController < ApplicationController
  def show
    @breed = Breed.find(params[:breed_id])
    @sub_breed = @breed.sub_breeds.find(params[:id])
  end
end
