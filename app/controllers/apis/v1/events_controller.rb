module Apis
  module V1
    #
    # Events Controller for event API's.
    #
    # @author [sreeraj s]
    #
    class EventsController < BaseApisController
      before_filter :find_event, only: [:show, :update, :destroy]

      MSG = YAML.load_file(GlobalConstants::MSG_PATH + 'events.yml')
                .deep_symbolize_keys

      # List all the events.
      # GET /apis/events
      def index
        msg = MSG[:index][:success]
        common_response(msg, events: Event.all)
      end

      # Create a new event.
      # POST /apis/events
      def create
        event = Event.new(event_params)
        if event.save
          msg = MSG[:create][:success]
        else
          @success = false
          msg = event.errors.full_messages
        end
        common_response(msg, event: event)
      end

      # Update an event.
      # PUT /apis/events/:id
      def update
        if @event.update(event_params)
          msg = MSG[:update][:success]
        else
          @success = false
          msg = @event.errors.full_messages
        end
        common_response(msg, event: @event)
      end

      # Details of a single event.
      # GET /apis/events/:id
      def show
        msg = MSG[:show][:success]
        common_response(msg, event: @event)
      end

      # Method to delete an event.
      # DELETE /apis/events/:id
      def destroy
        if @event.destroy
          msg = MSG[:destroy][:success]
        else
          @success = false
          msg = @event.errors.full_messages
        end
        common_response(msg)
      end

      private

      # Common method to find an event.
      def find_event
        @event = Event.find(params[:id])
      end

      # Strong parameters for an event.
      def event_params
        params.require(:events)
              .permit(:name, :description, :location)
      end
    end
  end
end
