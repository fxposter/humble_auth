require 'test_helper'
require 'generators/humble_auth/install_generator'

class HumbleAuth::Generators::InstallGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests HumbleAuth::Generators::InstallGenerator

  test "should invoke template engine" do
    run_generator
    assert_file "config/auth.yml", /SOMErandomSTRING/
  end
end
