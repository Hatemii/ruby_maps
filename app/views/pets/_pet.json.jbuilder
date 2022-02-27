json.extract! pet, :id, :name, :description, :species, :breed, :lost_on, :last_known_latitude, :last_known_longitude,
              :created_at, :updated_at
json.url pet_url(pet, format: :json)
