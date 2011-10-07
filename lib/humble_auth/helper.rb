module HumbleAuth
  module Helper
    def self.included(controller)
      controller.class_eval do
        helper_method :authenticated?
      end
    end
    
    protected
      def authenticated?
        authentication.check
      end

      def require_authentication
        if !authenticated? && process_authentication
          authentication.save
        end
      end

      def reset_authentication
        authentication.reset
      end

      def process_authentication
        if authentication.required?
          authenticate_or_request_with_http_basic { |username, password| authentication.validate(username, password) } == true
        else
          true
        end
      end
    
      def authentication
        @authentication ||= HumbleAuth::Auth.new(Rails.application.config.auth, cookies)
      end
  end
end
