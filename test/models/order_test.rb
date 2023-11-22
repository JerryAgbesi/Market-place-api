require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
    @product_one = products(:one)
    @product_two = products(:two)
  end

  test "should calculate total" do
    @order.placements = [Placement.new(product_id: @product_one.id,quantity: 2),Placement.new(product_id: @product_two.id,quantity: 2)]
    @order.set_total!

    assert_equal (@product_one.price * 2 + @product_two.price * 2),@order.total
  end

  test "builds two placements with product ids and quantities" do
    @order.build_placements_with_product_ids_and_quantities([{product_id:@product_one.id,quantity:2},{product_id:@product_two.id,quantity:3}])

    assert_difference("Placement.count",2) do
      @order.save
    end
  end

  # test "forbid creating an order with product quantity more than available" do
  #   @order.placements << Placement.new(product_id: @product_one.id,quantity: (1+@product_one.quantity))
  #   assert_not @order.valid?
  # end
end
