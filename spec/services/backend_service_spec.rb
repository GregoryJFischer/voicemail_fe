require 'rails_helper'

describe BackendService do

  it 'get an user', :vcr do
    user = User.create(email: 'bob@example.com', first_name: 'Bob', last_name: 'bob', google_id: '12345')
    session = {user_id: user.id, token: 'abcd', google_id: '12345'}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)

    stub_request(:get, "http://localhost:5000/users/11").
       with(
         headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.8.0'
         }).to_return(status: 200, body: "", headers: {})

    found_user = BackendService.get_user(11)
    
    expect(result).to be_empty
  end

  it 'can get data' do
    # found_user = BackendService.find_or_create_user(user_params)
    # result = BackendService.update_address(url, body)
    # found_reps = BackendService.representatives(user.id)
    # fetch = BackendService.fetch('/api/v1/')

    # expect(result).to be_a Hash
    # expect(result).not_to be_empty
  end

  # it 'stubs the response' do
  #   json_response = File.read('spec/fixtures/denver_representatives.json')
  #   # stub_request(:get, "api/v1/users/#{user.id}/representatives.json").to_return(status: 200, body: json_response)
  #   stub_request(:get, "http://localhost:5000/users/9/representatives").
  #   with(
  #     headers: {
  #       'Accept'=>'*/*',
  #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #       'User-Agent'=>'Faraday v1.8.0'
  #       }).
  #       to_return(status: 200, body: "", headers: {})
  # end

  # it 'can patch data' do
  #   url = '/api/v1/users/1'
  #   address_params = {
  #           street_address_1: params[:street_address_1],
  #           street_address_2: params[:street_address_2],
  #           city: params[:city],
  #           state: params[:state],
  #           zip_code: params[:zip_code]
  #         }.to_json
  #
  #   result = BackendService.update_address(address_params, url)
  #
  #   expect(result).to be_empty
  # end
end
