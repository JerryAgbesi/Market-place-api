require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with valid email should be valid" do
    user = User.create(email: "one@gmail.com",password_digest: "person1_pass")
    assert user.valid?
  end

  test "user with invalid email should be invalid" do
    user = User.create(email: "person1ingmail.com",password_digest: "person1_pass")
    assert_not user.valid?
  end

  test "user with taken email should be invalid" do
    existing_user = users(:one)
    user = User.create(email: existing_user.email ,password_digest: "person1_pass")
    assert_not user.valid?
  end

  test "destroy user should destroy corresponding products" do
    assert_difference('Product.count',-1) do
      users(:one).destroy
    end
  end
end
