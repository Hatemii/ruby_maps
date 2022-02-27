class PetsController < ApplicationController
  # check input date
  include PetsHelper

  # users can not craete, update, delet if they are not logged in!
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_pet, only: %i[edit update]

  # GET /pets or /pets.json
  def index
    @pets = Pet.all.order('created_at DESC')
  end

  # GET /pets/1 or /pets/1.json
  def show
    @pet = Pet.find(params[:id])
    @pet.as_json.merge(image: url_for(@pet.image)) unless @pet.image.blank?
    @pet
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
    @pet = Pet.find(params[:id])
  end

  # POST /pets or /pets.json
  def create
    if params[:form_on_submit]
      if check_date_helper(pet_params[:lost_on])
        respond_to do |format|
          format.html { redirect_to new_pet_path, alert: "Date #{pet_params[:lost_on].to_date} is not valid!" }
        end
      else
        @pet = Pets::PetCreateService.call(current_user, data)
        create_response(@pet, record_detail_data)
      end
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
    if pet_params[:lost_on].present? && check_date_helper(pet_params[:lost_on])
      respond_to do |format|
        format.html { redirect_to edit_pet_path(@pet), alert: "Date #{pet_params[:lost_on].to_date} is not valid!" }
      end
    else
      update_response(@pet, pet_params, record_detail_data)
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    @pet = Pet.find(params[:id])
    delete_response(@pet)
  end

  def remove_image
    @pet = Pet.find(params[:pet_id])
    if @pet.image.present?
      @pet.image.delete
      respond_to do |format|
        format.html { redirect_to @pet, notice: 'Image successfully removed' }
      end
    else
      respond_to do |format|
        format.html { redirect_to edit_pet_path(@pet), alert: 'No image available!' }
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
  def set_pet
    @pet = Pet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pet_params
    params.require(:pet).permit(:name, :description, :species, :breed, :lost_on, :latitude, :longitude, :image,
                                :other_info, :injured, :search)
  end

  def location_params
    params.require(:pet).permit(:route, :street_number, :neighborhood, :postal_code, :localicy, :country)
  end
end
