class Pet < ApplicationRecord
  has_one_attached :image
  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte}

  validates_presence_of  :name, :description, :species, :breed, :lost_on, :latitude, :longitude, on: :create
  has_many :pets

  def lost_on_format
    self.lost_on.strftime('%a, %d %b %Y') if self.lost_on.present?
  end

  before_save :handel_decimal_values
  
  def handel_decimal_values
    self.latitude = self.latitude.to_f if self.latitude.present? 
    self.longitude = self.longitude.to_f if self.longitude.present? 
  end

end
