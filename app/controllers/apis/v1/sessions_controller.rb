module Apis
  module V1
    #
    # Sessions Controller to handle login and logout.
    #
    # @author [sreeraj s]
    #
    class SessionsController < Devise::SessionsController
      protect_from_forgery with: :null_session,
                             if: proc { |c| c.request.format == API_FIRST_VERSION }

      skip_before_action :ensure_login, only: [:create, :destroy]

      MSG = YAML.load_file(GlobalConstants::MSG_PATH + 'sessions.yml')
                .deep_symbolize_keys

      # Sign In
      # POST /api/login
      # Params: email, password
      def create
        resource = warden.authenticate!(
          scope: resource_name,
          recall: "#{controller_path}#failure"
        )
        if resource
          return sign_in_and_redirect(resource_name, resource)
        else
          sign_out
          @success = false
          msg =
          render json: {
            success: false,
            message: t('devise.sessions.inactive_account')
          }, status: :unprocessable_entity
        end
      end

      # Sign out
      # DELETE /api/logout
      def destroy
        warden.authenticate!(
          scope: resource_name,
          recall: "#{controller_path}#failure"
        )
        sign_out
        render json: {
          success: true,
          message: t('devise.sessions.signed_out'),
          csrfParam: request_forgery_protection_token,
          csrfToken: form_authenticity_token
        }, status: :ok
      end

      # Failure
      def failure
        render json: {
          success: false,
          message: 'Invalid login credentials'
        }, status: :internal_server_error
      end

      # Logged in user
      # GET /apis/logged_in_user
      def logged_in_user
        warden.authenticate!(
          scope: resource_name,
          recall: "#{controller_path}#failure"
        )
        render json: {
          success: true,
          message: 'Logged in user',
          user: current_user
        }, status: :ok
      end

      # To handle signin and redirection.
      def sign_in_and_redirect(resource_or_scope, resource = nil)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        resource ||= resource_or_scope
        sign_in(scope, resource) unless warden.user(scope) == resource
        render json: {
          success: true,
          redirect_to: after_sign_in_path_for(:resource),
          message: t('devise.sessions.signed_in'),
          user: current_user
        }, status: :ok
      end

      private

      def after_sign_in_path_for(resource)
        request.env['omniauth.origin'] ||
          stored_location_for(resource) ||
          root_path
      end
    end
  end
end
