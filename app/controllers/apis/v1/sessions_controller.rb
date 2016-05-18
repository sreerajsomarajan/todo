module Apis
  module V1
    #
    # Sessions Controller to handle login and logout.
    #
    # @author [sreeraj s]
    #
    class SessionsController < Devise::SessionsController
      protect_from_forgery with: :null_session, if: valid_request?

      skip_before_action :ensure_login, only: [:create, :destroy]

      MSG = YAML.load_file(GlobalConstants::MSG_PATH + 'sessions.yml')
                .deep_symbolize_keys

      # Sign In
      # POST /api/login
      # Params: email, password
      def create
        user = warden.authenticate!(
          scope: resource_name,
          recall: "#{controller_path}#failure"
        )
        sign_in_and_redirect(resource_name, user) if user
        sign_out
        @success = false
        common_response(MSG[:inactive], status: :unprocessable_entity)
      end

      # Sign out
      # DELETE /api/logout
      def destroy
        warden.authenticate!(
          scope: resource_name,
          recall: "#{controller_path}#failure"
        )
        sign_out
        opt = {
          csrfParam: request_forgery_protection_token,
          csrfToken: form_authenticity_token
        }
        common_response(MSG[:logout][:success], opt)
      end

      # Failure
      def failure
        @success = false
        common_response(MSG[:failure], status: :internal_server_error)
      end

      # Logged in user
      # GET /apis/logged_in_user
      def logged_in_user
        warden.authenticate!(
          scope: resource_name,
          recall: "#{controller_path}#failure"
        )
        common_response(MSG[:logged_in], user: current_user)
      end

      # To handle signin and redirection.
      def sign_in_and_redirect(resource_or_scope, resource = nil)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        resource ||= resource_or_scope
        sign_in(scope, resource) unless warden.user(scope) == resource
        opt = {
          redirect_to: after_sign_in_path_for(:resource),
          user: current_user
        }
        common_response(MSG[:login][:success], opt)
      end

      private

      def valid_request?
        Proc.new { |c| c.request.format == API_FIRST_VERSION }
      end

      def after_sign_in_path_for(resource)
        request.env['omniauth.origin'] ||
          stored_location_for(resource) ||
          root_path
      end
    end
  end
end
