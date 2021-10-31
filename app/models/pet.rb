class Pet < ApplicationRecord
  has_one_attached :image
  has_many :comments, as: :commentable

  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte}

  validates_presence_of  :name, :description, :species, :breed, :lost_on, :latitude, :longitude, on: :create
  has_many :pets

  def lost_on_format
    self.lost_on.strftime('%a, %d %b %Y') if self.lost_on.present?
  end

  # callbacks
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

end
