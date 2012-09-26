module HumbleAuth
  module Helper
    def self.included(controller)
      controller.class_eval do
        helper_method :authenticated?
      end
    end

    def authenticated?
      authentication.check
    end

    def reset_authentication
      authentication.reset
    end

    protected
      def require_authentication
        if !authenticated? && process_authentication
          authentication.save
        end
      end

      def process_authentication
        if authentication.required?
          authenticate_or_request_with_http_basic { |username, password| authentication.validate(username, password) } === true
        else
          true
        end
      end

      def authentication
        @authentication ||= HumbleAuth::Auth.new(authentication_config, cookies)
      end

      def authentication_config
        Rails.application.config.auth
      end
  end
end
