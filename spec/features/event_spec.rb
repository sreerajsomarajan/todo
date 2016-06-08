#
# Event feature
#
# @author [sreeraj s]
#
require 'rails_helper'

RSpec.describe 'home page', type: :feature, js: true do
  let!(:event) { FactoryGirl.create(:event) }

  context 'when signed in' do
    it 'list all events' do
      visit root_path
      sleep(2)
      expect(page).to have_content event.name
    end
  end
end
