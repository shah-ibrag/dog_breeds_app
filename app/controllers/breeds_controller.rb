class BreedsController < ApplicationController
  def index
    if params[:search].present?
      case params[:search_type]
      when 'breeds'
        @breeds = Breed.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%").page(params[:page]).per(9)
      when 'sub_breeds'
        sub_breeds = SubBreed.where("LOWER(name) LIKE ?", "%#{params[:search].downcase}%")
        breed_ids = sub_breeds.pluck(:breed_id).uniq
        @breeds = Breed.where(id: breed_ids).page(params[:page]).per(9)
      else
        @breeds = Breed.page(params[:page]).per(9)
      end
    else
      @breeds = Breed.page(params[:page]).per(9)
    end
  end

  def show
    @breed = Breed.find_by(id: params[:id])
    
    if @breed.nil?
      flash[:alert] = "Breed not found."
      redirect_to breeds_path
    end
  end
end
