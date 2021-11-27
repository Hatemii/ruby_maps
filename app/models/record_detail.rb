class RecordDetail < ApplicationRecord
  belongs_to :record_detailable, polymorphic: true

  before_save :postal_code_handle
  
  def postal_code_handle
    self.postal_code == 0 ? self.postal_code = nil : nil  
  end
end
