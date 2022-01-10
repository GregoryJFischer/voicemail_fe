require 'rails_helper'

describe 'users dashboard', :vcr do
  before :each do
    @user = User.create(email: 'prisonmike@theoffice.com', name: 'Michael Scott')
    @session = {user_id: @user.id, token: 'abcd', google_id: '12345'}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(@session)
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
        stub_request(:get, "http://localhost:5000/api/v1/users/#{@user.id}/representatives").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v1.8.0'
            }).to_return(status: 200, body:
              {
                data: [
                  {
                    id: 0,
                    type: "representative",
                    attributes: {
                      address_city: "Washington",
                      address_line1: "1600 Pennsylvania Avenue Northwest",
                      address_state: "DC",
                      address_zip: "20500",
                      name: "Joseph R. Biden"
                    }
                    }]}.to_json,
                    headers: {})
                    found_user = BackendService.get_user("#{@user.id}")
                    found_rep = BackendService.representatives("#{@user.id}")
  end

  it 'should say hello' do
    visit '/dashboard'

    expect(page).to have_content "Welcome, Michael Scott"
  end

  it 'should have a button to update addresses' do
    visit '/dashboard'

    expect(page).to have_button "Add or update your current address"

    click_button "Add or update your current address"

    expect(current_path).to eq("/edit")
  end
end
