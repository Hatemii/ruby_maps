module FoundPetsHelper
  def check_date_helper(date)
    date.to_date < 3.years.ago || date.to_date > Time.zone.now.to_date
  end

  def create_response(found_pet, location_details)
    respond_to do |format|
      if found_pet.save
        RecordDetails::RecordDetailService.call(found_pet, location_details)

        format.html { redirect_to pets_toggle_index_path, notice: 'Pet was successfully created' }
        format.json { render :show, status: :created, location: found_pet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: found_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_response(found_pet, pet_params, _location_params)
    respond_to do |format|
      if found_pet.update(pet_params)
        format.html { redirect_to found_pet, notice: 'Pet was successfully updated' }
        format.json { render :show, status: :ok, location: found_pet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: found_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_response(found_pet)
    if found_pet.destroy
      respond_to do |format|
        format.html { redirect_to pets_toggle_index_path, notice: 'Pet was successfully destroyed' }
        format.json { head :no_content }
      end
    end
  end
end
