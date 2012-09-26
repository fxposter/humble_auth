require 'rails/railtie'
require 'humble_auth/helper'

module HumbleAuth
  class Railtie < Rails::Railtie
    initializer 'humble_auth.initialize' do
      config_file = Rails.root.join('config', 'auth.yml').to_s
      config.auth = HumbleAuth::Auth.make_config(File.exists?(config_file) ? YAML.load_file(config_file)[Rails.env]['auth'] : false)

      ActiveSupport.on_load :action_controller do
        include HumbleAuth::Helper
      end
    end
  end
end

