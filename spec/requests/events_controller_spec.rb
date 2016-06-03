#
# Spec EventsController
#
# @author [sreeraj s]
#
require 'rails_helper'

RSpec.describe 'Events', type: :request do
  let(:event) { FactoryGirl.create(:event) }

  before do
    event
  end

  it 'list all events' do
    get '/apis/events.json',
        nil,
        'Accept' => 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    expect(resp['success']).to eq true
    expect(resp['events'].size).to eq 1
    expect(resp['events'].first['name']).to eq event.name
  end

  it 'create an event' do
    post '/apis/events.json',
         events: event_params,
         'Accept' => 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    expect(resp['success']).to eq true
    expect(resp['message'].first).to eq 'Event has successfully created.'
    expect(resp['event']['name']).to eq event_params[:name]
    expect(resp['event']['description']).to eq event_params[:description]
    expect(resp['event']['location']).to eq event_params[:location]
  end

  def event_params
    {
      name: 'Test Event 2',
      description: 'Test Event 2 Description',
      location: 'Kollam'
    }
  end
end
