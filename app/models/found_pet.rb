class FoundPet < ApplicationRecord
  belongs_to :user
  
  validates_presence_of  :species, :breed, :found_on, :latitude, :longitude, :injured, :search, on: :create

  has_one_attached :image
  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte}

  def found_on_format
    self.found_on.strftime('%a, %d %b %Y') if self.found_on.present?
  end

  before_save :handel_decimal_values
  
  def handel_decimal_values
    self.latitude = self.latitude.to_f if self.latitude.present? 
    self.longitude = self.longitude.to_f if self.longitude.present? 
  end

end