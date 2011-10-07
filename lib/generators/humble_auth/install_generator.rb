require 'rails/generators'

module HumbleAuth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_auth_config
        copy_file 'auth.yml', 'config/auth.yml'
      end
    end
  end
end