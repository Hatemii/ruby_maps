class Pet < ApplicationRecord
  has_one_attached :image
  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte}

  validates_presence_of  :name, :description, :species, :breed, :lost_on, :last_known_latitude, :last_known_longitude
  has_many :pets
end
