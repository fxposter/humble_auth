module HumbleAuth
  class Auth
    def self.make_config(config)
      config ? ActiveSupport::OrderedOptions[config.symbolize_keys.to_a] : false
    end
    
    def initialize(config, store)
      @config = config
      @store = store
    end

    def required?
      @config
    end

    def validate(username, password)
      if @config
        username == @config.login && password == @config.password
      else
        true
      end
    end

    def save
      @store[:authentication_salt] = { :value => salt, :expires => 1.week.from_now }
    end

    def check
      @store[:authentication_salt] == salt
    end

    def reset
      @store.delete(:authentication_salt)
    end

    private
      def salt
        @config ? @config.salt : 'true'
      end
  end
end
