module Apis
  module V1
    #
    # Base Controller for v1 APIs
    #
    # @author [sreeraj s]
    #
    class BaseApisController < ApisController
      include ApiConcern
      before_action :initialize_default_instance_vars

      private

      # To initialize the default intance vars
      def initialize_default_instance_vars
        @success = true
      end
    end
  end
end
