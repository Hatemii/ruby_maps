module RecordDetails
  class RecordDetailService < ApplicationService

    def initialize(pet, *args)
      @pet = pet
      @data = args
    end
    
    def call
      create_record_details
    end

    def create_record_details
      @pet.record_details.create!(attributes)
    end

    def attributes
      @data[0].merge({created_at: Time.current, updated_at: Time.current})
    end
  end
end