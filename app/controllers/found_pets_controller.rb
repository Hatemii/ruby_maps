class FoundPetsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_found_pet, only: [:edit, :update]

  def index
    @found_pets = FoundPet.all.order("created_at DESC")
  end

  def show
    @found_pet = FoundPet.find(params[:id])
    @found_pet.as_json.merge(image: url_for(@found_pet.image)) if !@found_pet.image.blank?
    @found_pet
  end

  def new
    @found_pet = FoundPet.new
  end

  def edit
    @found_pet = FoundPet.find(params[:id])
  end

  def create
    if params[:form_on_submit]
      if pet_params[:found_on].to_date < 3.years.ago || pet_params[:found_on].to_date > Time.zone.now.to_date
        respond_to do |format|
          format.html {redirect_to new_found_pet_path, alert: "Date #{pet_params[:found_on].to_date} is not valid!"}
        end
      else
        @found_pet = current_user.found_pets.create(pet_params)
        @found_pet.save
        
        respond_to do |format|
          if @found_pet.save
            format.html { redirect_to pets_toggle_index_path, notice: "Pet was successfully created" }
            format.json { render :show, status: :created, location: @found_pet }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @found_pet.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end


  def update
     if pet_params[:found_on].present? && (pet_params[:found_on].to_date < 3.years.ago || pet_params[:found_on].to_date > Time.zone.now.to_date)
      respond_to do |format|
        format.html {redirect_to edit_found_pet_path(@found_pet), alert: "Date #{pet_params[:found_on].to_date} is not valid!"}
      end
    else
      respond_to do |format|
        if @found_pet.update(pet_params)
          format.html { redirect_to @found_pet, notice: "Pet was successfully updated" }
          format.json { render :show, status: :ok, location: @found_pet }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @found_pet.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @found_pet = FoundPet.find(params[:id])
    @found_pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_toggle_index_path, notice: "Pet was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  def remove_image
    @found_pet = FoundPet.find(params[:pet_id])
    if @found_pet.image.present?
      @found_pet.image.delete 
      respond_to do |format|
        format.html {redirect_to @found_pet, notice: "Image successfully removed"}
      end
    else
      respond_to do |format|
        format.html {redirect_to edit_found_pet_path(@found_pet), alert: "No image available!"}
      end
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_found_pet
      @found_pet = FoundPet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:found_pet).permit(:species, :breed, :found_on, :latitude, :longitude, :image, :other_info, :injured, :search)
    end
end
