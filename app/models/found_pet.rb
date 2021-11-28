class FoundPet < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :record_details, as: :record_detailable
  
  validates_presence_of  :species, :breed, :found_on, :latitude, :longitude, :injured, :search, on: :create

  has_one_attached :image
  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte}

  def found_on_format
    self.found_on.strftime('%a, %d %b %Y') if self.found_on.present?
  end

  before_save :handel_decimal_values
  after_create :no_image_handle
  
  def handel_decimal_values
    self.latitude = self.latitude.to_f if self.latitude.present? 
    self.longitude = self.longitude.to_f if self.longitude.present? 
  end

   def no_image_handle
    self.image.attach( 
      io: File.open( Rails.root.join('app', 'assets', 'images', 'cat.jpg')), filename: 'cat.jpg') if self.species == "Cat" && !self.image.attached?
      
    self.image.attach( 
      io: File.open( Rails.root.join('app', 'assets', 'images', 'dog.jpg')), filename: 'dog.jpg') if self.species == "Dog" && !self.image.attached?
    
    self.image.attach( 
      io: File.open( Rails.root.join('app', 'assets', 'images', 'bird.jpg')), filename: 'bird.jpg') if self.species == "Bird" && !self.image.attached? 
      
    self.image.attach( 
      io: File.open( Rails.root.join('app', 'assets', 'images', 'no_image.jpg')), filename: 'no_image.jpg') if !self.image.attached?  
  end

  def find_location_details
    self.record_details[0]
  end
  
end