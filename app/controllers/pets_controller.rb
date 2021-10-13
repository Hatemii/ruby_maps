class PetsController < ApplicationController

  # users can not craete, update, delet if they are not logged in!
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_pet, only: [:edit, :update]

  # GET /pets or /pets.json
  def index
    @pets = Pet.all.order("created_at DESC")
  end

  # GET /pets/1 or /pets/1.json
  def show
    @pet = Pet.find(params[:id])
    @pet.as_json.merge(image: url_for(@pet.image)) if !@pet.image.blank?
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
    if pet_params[:lost_on].to_date < 3.years.ago || pet_params[:lost_on].to_date > Time.zone.now.to_date
      respond_to do |format|
        format.html {redirect_to new_pet_path, alert: "Date #{pet_params[:lost_on].to_date} is not valid!"}
      end
    else
      @pet = current_user.pets.create(pet_params)
      @pet.save
      
      respond_to do |format|
        if @pet.save
          format.html { redirect_to @pet, notice: "Pet was successfully created" }
          format.json { render :show, status: :created, location: @pet }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @pet.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
     if pet_params[:lost_on].present? && (pet_params[:lost_on].to_date < 3.years.ago || pet_params[:lost_on].to_date > Time.zone.now.to_date)
      respond_to do |format|
        format.html {redirect_to edit_pet_path(@pet), alert: "Date #{pet_params[:lost_on].to_date} is not valid!"}
      end
    else
      respond_to do |format|
        if @pet.update(pet_params)
          format.html { redirect_to @pet, notice: "Pet was successfully updated" }
          format.json { render :show, status: :ok, location: @pet }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @pet.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_toggle_index_path, notice: "Pet was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  def remove_image
    @pet = Pet.find(params[:pet_id])
    if @pet.image.present?
      @pet.image.delete 
      respond_to do |format|
        format.html {redirect_to @pet, notice: "Image successfully removed"}
      end
    else
      respond_to do |format|
        format.html {redirect_to edit_pet_path(@pet), alert: "No image available!"}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:name, :description, :species, :breed, :lost_on, :latitude, :longitude,:image, :other_info, :injured, :search)
    end
end
