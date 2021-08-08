class Pet < ApplicationRecord
  has_one_attached :image
  validates :image, blob: { content_type: :image, size_range: 1..5.megabyte}
end
