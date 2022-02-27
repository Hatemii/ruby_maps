class Pet < ApplicationRecord
  has_one_attached :image
  has_many :comments, as: :commentable
  has_many :record_details, as: :record_detailable, dependent: :destroy

  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte }

  validates_presence_of :name, :description, :species, :breed, :lost_on, :latitude, :longitude, on: :create
  has_many :pets

  def lost_on_format
    lost_on.strftime('%a, %d %b %Y') if lost_on.present?
  end

  # callbacks
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

  def find_record_details
    record_details[0]
  end
end
