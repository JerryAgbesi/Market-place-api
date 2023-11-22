class Placement < ApplicationRecord
  belongs_to :product, inverse_of: :placements
  belongs_to :order
  after_create :decrease_product_quantity

  def decrease_product_quantity
    product.decrement!(:quantity,quantity)
  end
end
