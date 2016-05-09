module Api
  module V1
    #
    # Events Controller for event API's.
    #
    # @author [sreeraj s]
    #
    class EventsController < BaseApisController
      before_filter :find_event, only: [:show, :update]

      # List all the events
      # GET /apis/events
      def index
        render json: Event.all
      end

      # Add a new event
      # POST /apis/events
      def create
        data = Event.create!(event_params)
                 { data: data, status: :created }
               rescue => e
               end
        render json: data, status: :created
      end

      private

      def find_event
        @event = Event.find(params[:id])
      end

      def event_params
        params.require(:events)
              .permit(:name, :description, :location)
      end
    end
  end
end
