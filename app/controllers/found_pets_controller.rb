class FoundPetsController < ApplicationController
  include FoundPetsHelper

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_found_pet, only: %i[edit update]

  def index
    @found_pets = FoundPet.all.order('created_at DESC')
  end

  def show
    @found_pet = FoundPet.find(params[:id])
    @found_pet.as_json.merge(image: url_for(@found_pet.image)) unless @found_pet.image.blank?
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
      if check_date_helper(pet_params[:found_on])
        respond_to do |format|
          format.html { redirect_to new_found_pet_path, alert: "Date #{pet_params[:found_on].to_date} is not valid!" }
        end
      else
        @found_pet = FoundPets::FoundPetCreateService.call(current_user, data)
        create_response(@found_pet, location_params)
      end
    end
  end

  def update
    if pet_params[:found_on].present? && check_date_helper(pet_params[:found_on])
      respond_to do |format|
        format.html do
          redirect_to edit_found_pet_path(@found_pet), alert: "Date #{pet_params[:found_on].to_date} is not valid!"
        end
      end
    else
      update_response(@found_pet, pet_params, location_params)
    end
  end

  def destroy
    @found_pet = FoundPet.find(params[:id])
    delete_response(@found_pet)
  end

  def remove_image
    @found_pet = FoundPet.find(params[:pet_id])
    if @found_pet.image.present?
      @found_pet.image.delete
      respond_to do |format|
        format.html { redirect_to @found_pet, notice: 'Image successfully removed' }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_found_pet_path(@found_pet), alert: 'No image available!' }
      end
    end
  end

  private

  def data
    pet_params.to_h.compact
  end

  def record_detail_data
    location_params.to_h
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_found_pet
    @found_pet = FoundPet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pet_params
    params.require(:found_pet).permit(:species, :breed, :found_on, :latitude, :longitude, :image, :other_info,
                                      :injured, :search)
  end

  def location_params
    params.require(:found_pet).permit(:route, :street_number, :neighborhood, :postal_code, :localicy, :country)
  end
end
