require 'rails_helper'

describe BackendService do
  before :each do
    @user = User.new(user_data_with_address)
    @session = { user_id: @user.user_id, token: 'abcd', google_id: '12345' }
    allow_any_instance_of(ApplicationController).to receive(:session).and_return(@session)
  end

  it 'can get a user', :vcr do
    response = BackendService.get_user(@user.user_id)
    expect(response).to be_a Hash
  end

  it 'can patch data', :vcr do

    address_params = {
      address_line1: '123 Main Street',
      address_city: 'city a',
      address_state: 'state b',
      address_zip: '12345'
    }
  end
end
