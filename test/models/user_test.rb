require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Test",email:"test@gmail.com",password:"123123", 
                    password_confirmation: "123123")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "Email validation should accpet valid addressees" do
    valid_addresses = %w[dinhson@foo.com DINHSON@yahoo.com.vn dinh_thanh_son@gmail.com]
    valid_addresses.each do |valid_address|
      @user.email= valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
 
  test "Email invalid should reject invalid addresses" do 
    invalid_addresses = %w[dinhson@foo,com DINHSONyahoo.com.vn dinh_thanh_son@yahoo+gmail.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "Email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "Pass should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
