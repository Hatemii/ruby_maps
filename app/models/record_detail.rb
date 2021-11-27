class RecordDetail < ApplicationRecord
  belongs_to :record_detailable, polymorphic: true
end
