require 'rails_helper'

describe BackendService do
  before :each do
    @user = User.create(email: 'prisonmike@theoffice.com', name: 'Michael Scott')
    @session = {user_id: @user.id, token: 'abcd', google_id: '12345'}
    allow_any_instance_of(ApplicationController).to receive(:session).and_return(@session)
  end

  it 'get an user' do
    stub_request(:get, "http://localhost:5000/api/v1/users/#{@user.id}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.8.0'
        }).to_return(status: 200, body:
          { data: {
            id: @user.id,
            type: "user",
            attributes: {
              email: @user.email,
              name: @user.name,
              google_id: @user.google_id,
              address_line1: nil,
              address_line2: nil,
              address_city: nil,
              address_state: nil,
              address_zip: nil
            }
          }
        }.to_json,
        headers: {} )

    response = BackendService.get_user(@user.id)
    expect(response).to be_a Hash
  end

  it 'can patch data' do
    stub_request(:patch, "http://localhost:5000/api/v1/users/#{@user.id}").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.8.0'
        }).to_return(status: 200, body:
          { data: {
            id: @user.id,
            type: "user",
            attributes: {
              email: @user.email,
              name: @user.name,
              google_id: @user.google_id,
              address_line1: nil,
              address_line2: nil,
              address_city: nil,
              address_state: nil,
              address_zip: nil
            }
          }
        }.to_json,
        headers: {} )

    address_params = {
                      address_line1: '123 Main Street',
                      address_city: 'city a',
                      address_state: 'state b',
                      address_zip: '12345'
                      }

  end
end
