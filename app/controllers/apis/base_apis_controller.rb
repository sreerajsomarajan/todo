#
# Apis Controller for todo API's.
#
# @author [sreeraj s]
#
module Api
  module v1
		class BaseApisController < ApplicationController
      before_filter :set_instance_variable

      def set_instance_variable
        @success = true
      end
		end
	end
end
