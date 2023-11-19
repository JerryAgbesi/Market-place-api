require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @user.email,json_response['email']

  end

  test "should create a new user" do
    assert_difference('User.count') do
      post api_v1_users_url, params: {user: {email: 'test@testorg',password:'1234567'}}, as: :json
    end
    assert_response :created
  end

  test "should not create user with taken email" do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: {user: {email: @user.email ,password:'1234567'}}, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update user details" do
    patch api_v1_user_url(@user), params: {user: {email: 'joeman@gmail.com',password:'125678'}}, as: :json
    assert_response :success
  end

  test "should not update user details with invalid paramaters" do
    patch api_v1_user_url(@user), params: {user: {email: 'joemangmail.com',password:'125678'}}, as: :json
    assert_response :unprocessable_entity
  end

end
