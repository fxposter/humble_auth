require 'rails/railtie'
require 'humble_auth/helper'

module HumbleAuth
  class Railtie < Rails::Railtie
    initializer 'humble_auth.initialize' do
      config_file = Rails.root.join('config', 'auth.yml').to_s
      
      if File.exists?(config_file)
        config.auth = HumbleAuth::Auth.make_config(YAML.load_file(config_file)[Rails.env]['auth'])
      else
        puts 'Write your authentication data into config/auth.yml file!'
      end
      
      ActiveSupport.on_load :action_controller do
        include HumbleAuth::Helper
      end
    end
  end
end

