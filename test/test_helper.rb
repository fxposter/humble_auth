require 'bundler/setup'
require 'test/unit'
begin
  require 'minitest/autorun'
rescue LoadError
end

require 'humble_auth'
require 'action_controller'
require 'active_support/core_ext'
