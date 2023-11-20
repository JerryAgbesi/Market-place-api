class Placement < ApplicationRecord
  belongs_to :product, inverse_of: :placements
  belongs_to :order
end
