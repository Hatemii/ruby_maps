class FoundPetsController < ApplicationController
  def index
    @found_pets = FoundPet.all.order("ID DESC")
  end
end
