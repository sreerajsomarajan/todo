module Apis
  module V1
    #
    # Users Controller for all user actions.
    #
    # @author [sreeraj s]
    #
    class UsersController < BaseApisController
      before_filter :find_user, only: [:show, :edit, :destroy]

      MSG = YAML.load_file(GlobalConstants::MSG_PATH + 'users.yml')
                .deep_symbolize_keys

      # List all the users.
      # GET /apis/users
      def index
        msg = MSG[:index][:success]
        common_response(msg, users: User.all)
      end

      # Create a new user.
      # POST /apis/users
      def create
        user = User.new(user_params)
        if user.save
          msg = MSG[:create][:success]
        else
          @success = false
          msg = user.errors.full_message
        end
        common_response(msg, user: user)
      end

      # Update a user.
      # PUT /apis/users/:id
      def update
        if @user.update(user_params)
          msg = MSG[:update][:success]
        else
          @success = false
          msg = @user.errors.full_message
        end
        common_response(msg, user: user)
      end

      # Details of a single user.
      # GET /apis/users/:id
      def show
        msg = MSG[:show][:success]
        common_response(msg, user: @user)
      end

      # Method to delete a user
      # DELETE /apis/users/:id
      def destroy
        if @user.destroy
          msg = MSG[:destroy][:success]
        else
          @success = false
          msg = @user.errors.full_message
        end
        common_response(msg, user: @user)
      end

      private

      # Method to find single user.
      def find_user
        @user = User.find(params[:id])
      end

      # Strong parameters for a user.
      def user_params
        params.require(:user)
              .permit([:first_name, :last_name, :email, :password])
      end
    end
  end
end
