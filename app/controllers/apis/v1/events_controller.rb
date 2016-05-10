module Apis
  module V1
    #
    # Events Controller for event API's.
    #
    # @author [sreeraj s]
    #
    class EventsController < BaseApisController
      before_filter :find_event, only: [:show, :update, :destroy]

      # List all the events
      # GET /apis/events
      def index
        render json: Event.all
      end

      # Add a new event
      # POST /apis/events
      def create
        event = Event.new(event_params)
        if event.save
          msg = 'Event has successfully created.'
        else
          @success = false
          msg = event.errors.full_messages
        end
        common_response(msg, event: event)
      end

      # Update an event
      # PUT /apis/events/:id
      def update
        if @event.update(event_params)
          msg = 'Event has successfully updated.'
        else
          @success = false
          msg = @event.errors.full_messages
        end
        common_response(msg, event: @event)
      end

      # Get an event
      # GET /apis/events/:id
      def show
        render json: { event: @event }
      end

      # Delete an event
      # DELETE /apis/events/:id
      def destroy
        if @event.destroy
          msg = 'Event has successfully deleted.'
        else
          @success = false
          msg = @event.errors.full_messages
        end
        common_response(msg)
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
