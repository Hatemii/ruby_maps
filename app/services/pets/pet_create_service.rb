module Pets
  class PetCreateService < ApplicationService

    def initialize(current_user, *args)
      @current_user = current_user
      @data = args
    end
    
    def current_user
      @current_user
    end

    def call
      create_pet_process
    end

    def create_pet_process
      current_user.pets.create!(attributes)
    end

    def attributes
      @data[0].merge({created_at: Time.current, updated_at: Time.current})
    end
  end
end