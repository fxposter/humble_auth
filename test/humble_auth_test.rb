require 'test_helper'

class DisabledAuthTest < ActiveSupport::TestCase
  setup do
    @store = ActionDispatch::Cookies::CookieJar.new
    @config = HumbleAuth::Auth.make_config(false)
    @auth ||= HumbleAuth::Auth.new(@config, @store)
  end

  test "authentication is not required when config is false" do
    assert !@auth.required?
  end

  test "validates any login / password pair" do
    assert @auth.validate('A', 'B')
    assert @auth.validate('C', 'D')
  end

  test "saves 'true' value to the store with key :authentication_salt on #save" do
    @auth.save
    assert_equal @store[:authentication_salt], 'true'
  end

  test "resets :authentication_salt key in store on #reset" do
    @auth.save
    @auth.reset
    assert_equal @store[:authentication_salt], nil
  end
end

class EnabledAuthTest < ActiveSupport::TestCase
  setup do
    @store = ActionDispatch::Cookies::CookieJar.new
    @config = HumbleAuth::Auth.make_config(:login => 'YourLogin', :password => 'YoURPAsSwORd', :salt => 'SOMErandomSTRING')
    @auth ||= HumbleAuth::Auth.new(@config, @store)
  end

  test "authentication is required when config is a hash" do
    assert @auth.required?
  end

  test "validates only login / password pair, that was specified in config" do
    assert @auth.validate('YourLogin', 'YoURPAsSwORd')
    assert !@auth.validate('YourLogin', 'BADPASSWORD')
    assert !@auth.validate('BADLOGIN', 'YoURPAsSwORd')
    assert !@auth.validate('BADLOGIN', 'BADPASSWORD')
  end

  test "saves salt value to the store with key :authentication_salt on #save" do
    @auth.save
    assert_equal @store[:authentication_salt], 'SOMErandomSTRING'
  end

  test "resets :authentication_salt key in store on #reset" do
    @auth.save
    @auth.reset
    assert_equal @store[:authentication_salt], nil
  end
end
