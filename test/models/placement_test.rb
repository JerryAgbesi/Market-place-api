require "test_helper"

class PlacementTest < ActiveSupport::TestCase
  setup do
    @placement = placements(:one)
  end

  test "should decrease product quantity on create" do
    product = @placement.product

    assert_difference('product.quantity',-@placement.quantity) do
      @placement.decrease_product_quantity
    end
  end
end
