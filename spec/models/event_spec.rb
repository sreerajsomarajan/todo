#
# Spec Event
#
# @author [sreeraj s]
#
require 'rails_helper'

describe Event do
  describe '.create' do
    context 'when trying to create duplicates' do
      it 'should not create the records' do
        Event.create(name: 'Testing_2')
        event = Event.create(name: 'Testing_2')
        expect(event.errors.full_messages.first).to match /Name has already been taken/i
      end
    end
  end
end
