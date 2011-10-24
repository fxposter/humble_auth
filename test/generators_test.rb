require 'test_helper'
require 'generators/humble_auth/install_generator'

class HumbleAuth::Generators::InstallGeneratorTest < Rails::Generators::TestCase
  destination File.expand_path('../../tmp/', __FILE__)
  tests HumbleAuth::Generators::InstallGenerator

  test "should invoke template engine" do
    run_generator
    assert_file "config/auth.yml", /SOMErandomSTRING/
  end
end
