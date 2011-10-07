module HumbleAuth
  module Helper
    protected
      def authenticated?
        authentication.check
      end

      def require_authentication
        unless authenticated?
          process_authentication
          authentication.save
        end
      end

      def reset_authentication
        authentication.reset
      end

      def process_authentication
        if authentication_manager.require_authentication?
          authenticate_or_request_with_http_basic do |username, password|
            authentication_manager.validate(username, password)
          end
        else
          true
        end
      end
    
      def authentication_manager
        @authentication_manager ||= HumbleAuth::Manager.new(Rails.application.config.auth, cookies)
      end
  end
end
