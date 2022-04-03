  require 'rails_helper'

describe 'letter confirmation', type: :system do
  before(:each) do
    user_params = { email: Faker::Internet.unique.email, name: 'Alex' }
    new_user = BackendService.find_or_create_user(user_params)
    session = { user_id: new_user[:data][:id] }

    address = {
      address_line1: '1551 Utica St',
      address_city: 'Denver',
      address_state: 'CO',
      address_zip: '80204'
    }

    response = BackendService.update_address(new_user[:data][:id], address)
    @user = JSON.parse(response.body, symbolize_names: true)
    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)
  end
end