require 'rails_helper'

describe BackendService do
  before :each do
    @user = User.new({data: 
                        {id: "1",
                        type: "user",
                        attributes: 
                          {email: "isabel_wuckert@damore-feil.name",
                          name: "Greg",
                          google_id: nil,
                          address: 
                            {id: 1,
                            address_line1: "12012 starboard dr",
                            address_line2: "apt 205",
                            address_city: "reston",
                            address_state: "va",
                            address_zip: "20194",
                            created_at: "2022-05-19T20:01:43.555Z",
                            updated_at: "2022-05-19T20:01:43.570Z",
                            user_id: 1,
                            name: "Greg",
                            address_country: "US"}}}}
                    )
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
