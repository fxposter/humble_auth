require 'test_helper'

class HelperTest < ActionController::TestCase
  Routes = ActionDispatch::Routing::RouteSet.new
  Routes.draw do
    get ':controller(/:action)'
  end
  Routes.finalize!

  class DummyController < ActionController::Base
    include HumbleAuth::Helper
    before_filter :require_authentication

    include Routes.url_helpers

    def authentication_config
      HumbleAuth::Auth.make_config(:login => 'YourLogin', :password => 'YoURPAsSwORd', :salt => 'SOMErandomSTRING')
    end

    def index
      head :ok
    end
  end

  tests DummyController

  setup do
    @routes = Routes
  end

  test "deny access for users, who don't provide credentials" do
    get :index
    assert_response :unauthorized
    assert !@controller.authenticated?
  end

  test "prevent authentication on subsequent requests for users, who don't provide credentials" do
    get :index
    get :index
    assert_response :unauthorized
    assert !@controller.authenticated?
  end

  test "allow access for users, who provide credentials" do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials('YourLogin', 'YoURPAsSwORd')
    get :index
    assert_response :success
    assert @controller.authenticated?
  end

  test "allow access for users, who provide credentials on subsequest requests" do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials('YourLogin', 'YoURPAsSwORd')
    get :index
    @request.env['HTTP_AUTHORIZATION'] = nil
    get :index
    assert_response :success
    assert @controller.authenticated?
  end

  test "deny access for users after resetting authenticaton" do
    @request.env['HTTP_AUTHORIZATION'] = encode_credentials('YourLogin', 'YoURPAsSwORd')
    get :index
    @request.env['HTTP_AUTHORIZATION'] = nil
    @controller.reset_authentication
    get :index
    assert_response :unauthorized
  end

  private
    def encode_credentials(username, password)
      "Basic #{(defined?(::Base64) ? ::Base64 : ::ActiveSupport::Base64).encode64("#{username}:#{password}")}"
    end
end
