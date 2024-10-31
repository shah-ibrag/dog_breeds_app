class BreedsController < ApplicationController
  def index
    if params[:search].present?
      @breeds = Breed.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%").page(params[:page]).per(9)
    else
      @breeds = Breed.page(params[:page]).per(9)
    end
  end

  def show
    @breed = Breed.find_by(id: params[:id])
    
    # Redirect if breed is not found
    if @breed.nil?
      flash[:alert] = "Breed not found."
      redirect_to breeds_path
    end
  end
end
