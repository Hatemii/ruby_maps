class FoundPet < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :record_details, as: :record_detailable, dependent: :destroy

  validates_presence_of :species, :breed, :found_on, :latitude, :longitude, :search, :other_info, on: :create

  has_one_attached :image
  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte }

  def found_on_format
    found_on.strftime('%a, %d %b %Y') if found_on.present?
  end

  before_save :handel_decimal_values
  after_create :no_image_handle

  def handel_decimal_values
    self.latitude = latitude.to_f if latitude.present?
    self.longitude = longitude.to_f if longitude.present?
  end

  def no_image_handle
    if species == 'Cat' && !image.attached?
      image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images',
                                      'cat.jpg')), filename: 'cat.jpg'
      )
    end

    if species == 'Dog' && !image.attached?
      image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images',
                                      'dog.jpg')), filename: 'dog.jpg'
      )
    end

    if species == 'Bird' && !image.attached?
      image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images',
                                      'bird.jpg')), filename: 'bird.jpg'
      )
    end

    unless image.attached?
      image.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images',
                                      'no_image.jpg')), filename: 'no_image.jpg'
      )
    end
  end

  def find_location_details
    record_details[0]
  end
end
