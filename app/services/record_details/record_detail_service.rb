module RecordDetails
  class RecordDetailService < ApplicationService
    def initialize(object, *args)
      @object = object
      @data = args
    end

    attr_reader :object, :data

    def call
      create_record_details
    end

    def create_record_details
      object.record_details.create!(attributes)
    end

    def attributes
      data[0].merge({ created_at: Time.current, updated_at: Time.current })
    end
  end
end
