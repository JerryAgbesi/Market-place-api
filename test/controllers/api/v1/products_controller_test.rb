require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should show product" do
    get api_v1_product_url(@product), as: :json
    assert_response :success

    json_response = JSON.parse(response.body,symbolize_names: true)
    assert_equal @product.title,json_response.dig(:data,:attributes,:title)
    assert_equal @product.user.id.to_s,json_response.dig(:data,:relationships,:user,:data,:id)
    assert_equal @product.user.email,json_response.dig(:included,0,:attributes,:email)
  end

  test "should show products" do
    get api_v1_products_url, as: :json
    assert_response :success
  end

  test "should create a product with the product owner ID" do
    assert_difference('Product.count') do
      post api_v1_products_url, params: {product: {title: @product.title,price:@product.price,published:@product.published}},
           headers:{Authorization:JsonWebToken.encode(user_id: @product.user_id)}, as: :json
    end
    assert_response :created
  end

  test "should forbid creating a product" do
    assert_no_difference('Product.count') do
      post api_v1_products_url, params: {product: {title: @product.title,price:@product.price,published:@product.published}},as: :json
    end
    assert_response :forbidden
  end

  test "should update a product" do
    patch api_v1_product_url(@product), params: {product: {title: @product.title}},
           headers:{Authorization:JsonWebToken.encode(user_id: @product.user_id)}, as: :json
    assert_response :success
  end

  test "should forbid update of a product" do
    patch api_v1_product_url(@product), params: {product: {title: @product.title}},
          headers:{Authorization:JsonWebToken.encode(user_id: products(:two).user_id)},as: :json
    assert_response :forbidden
  end

  test "should delete a product" do
    assert_difference('Product.count',-1) do
      delete api_v1_product_url(@product),
            headers:{Authorization:JsonWebToken.encode(user_id: @product.user_id)}, as: :json
    end

    assert_response :no_content
  end

  test "should forbid deleting a product" do
    assert_no_difference('Product.count') do
      delete api_v1_product_url(@product),
             headers:{Authorization:JsonWebToken.encode(user_id: products(:two).user_id)},as: :json
    end
    assert_response :forbidden
  end
end
