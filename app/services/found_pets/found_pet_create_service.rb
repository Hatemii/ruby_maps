module FoundPets
  class FoundPetCreateService < ApplicationService
    def initialize(current_user, *args)
      @current_user = current_user
      @data = args
    end

    attr_reader :current_user

    def call
      create_found_pet_process
    end

    def create_found_pet_process
      current_user.found_pets.create!(attributes)
    end

    def attributes
      @data[0].merge({ created_at: Time.current, updated_at: Time.current })
    end
  end
end
