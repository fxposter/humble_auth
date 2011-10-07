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
        unless authenticated?
          process_authentication
          authentication.save
        end
      end

      def reset_authentication
        authentication.reset
      end

      def process_authentication
        if authentication.required?
          authenticate_or_request_with_http_basic do |username, password|
            authentication.validate(username, password)
          end
        else
          true
        end
      end
    
      def authentication
        @authentication ||= HumbleAuth::Auth.new(Rails.application.config.auth, cookies)
      end
  end
end
