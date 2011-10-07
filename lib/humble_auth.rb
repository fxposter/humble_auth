module HumbleAuth
  autoload :Auth, 'humble_auth/auth'
  autoload :Helper, 'humble_auth/helper'
end

require 'humble_auth/railtie' if defined?(Rails)
