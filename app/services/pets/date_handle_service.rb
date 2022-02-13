module Pets
  class DateHandleService < ApplicationService

    def initialize(date)
      @date = date
    end

    def call
      return true if convert_date < 3.years.ago || convert_date > Time.zone.now.to_date
    end

    def convert_date
      @date.to_date
    end
  end
end