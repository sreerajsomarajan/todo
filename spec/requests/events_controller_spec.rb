#
# Spec EventsController
#
# @author [sreeraj s]
#
require 'rails_helper'

RSpec.describe 'Events', type: :request do
  let!(:event) { FactoryGirl.create(:event) }

  it 'list all events' do
    get '/apis/events.json',
        Accept: 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    events = resp['events']
    expect(resp['success']).to eq true
    expect(events.size).to eq 1
    expect(events.first['name']).to eq event.name
  end

  it 'create an event' do
    post '/apis/events.json',
         events: event_params,
         Accept: 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    expect(resp['success']).to eq true
    expect(resp['message'].first).to eq 'Event has successfully created.'
    expect(resp['event']['name']).to eq event_params[:name]
    expect(resp['event']['description']).to eq event_params[:description]
    expect(resp['event']['location']).to eq event_params[:location]
  end

  it 'update an existing event' do
    put "/apis/events/#{event.id}.json",
        events: event_params,
        Accept: 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    expect(resp['message'].first).to eq 'Event has successfully updated.'
    expect(resp['event']['id']).to eq event.id
    expect(resp['event']['name']).to eq event_params[:name]
    expect(resp['event']['description']).to eq event_params[:description]
    expect(resp['event']['location']).to eq event_params[:location]
  end

  it 'show a single event' do
    get "/apis/events/#{event.id}.json",
        Accept: 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    expect(resp['event']['id']).to eq(event.id)
    expect(resp['event']['name']).to eq(event.name)
    expect(resp['event']['description']).to eq(event.description)
  end

  it 'delete a single event' do
    delete "/apis/events/#{event.id}",
           Accept: 'application/todoApp.v1'
    resp = JSON.parse(response.body)
    expect(resp['message'].first).to eq('Event has successfully deleted.')
  end

  def event_params
    {
      name: 'Test Event 2',
      description: 'Test Event 2 Description',
      location: 'Kollam'
    }
  end
end
