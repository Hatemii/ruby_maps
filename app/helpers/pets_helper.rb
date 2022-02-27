module PetsHelper
  def check_date_helper(date)
    date.to_date < 3.years.ago || date.to_date > Time.zone.now.to_date
  end

  def create_response(pet, location_details)
    respond_to do |format|
      if pet.save!
        RecordDetails::RecordDetailService.call(pet, location_details)

        format.html { redirect_to pets_toggle_index_path, notice: 'Pet was successfully created' }
        format.json { render :show, status: :created, location: pet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_response(pet, pet_params, _location_details)
    respond_to do |format|
      if pet.update(pet_params)
        format.html { redirect_to pet, notice: 'Pet was successfully updated' }
        format.json { render :show, status: :ok, location: pet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_response(pet)
    if pet.destroy
      respond_to do |format|
        format.html { redirect_to pets_toggle_index_path, notice: 'Pet was successfully destroyed' }
        format.json { head :no_content }
      end
    end
  end
end
