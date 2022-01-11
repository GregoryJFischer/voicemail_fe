require 'rails_helper'

describe 'user edit' do
  it "cant access the page without being logged in" do
    visit '/edit'

    expect(page).to have_content('You must be logged in to visit this page')
    expect(current_path).to eq root_path
  end

  it "should be able to edit the user's address" do
    @user = User.create(email: 'prisonmike@theoffice.com', name: 'Michael Scott')
    @session = {user_id: @user.id, token: 'abcd', google_id: '12345'}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(@session)

    visit '/edit'

    expect(page).to have_content("Address Line 1")
    expect(page).to have_content("Address Line 2")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip Code")
    expect(page).to have_button("Save")

    # click_on "Save"

    # expect(current_path).to eq '/dashboard'

    # stub_request(:patch, "http://localhost:5000/api/v1/users/#{@user.id}").
    # with(
    #   headers: {
    #     'Accept'=>'*/*',
    #     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #     'User-Agent'=>'Faraday v1.8.0'
    #     }).to_return(status: 200, body:
    #       { data: {
    #         id: @user.id,
    #         type: "user",
    #         attributes: {
    #           email: @user.email,
    #           name: @user.name,
    #           google_id: @user.google_id,
    #           address_line1: '330 Main Street',
    #           address_line2: nil,
    #           address_city: 'city a',
    #           address_state: 'state b',
    #           address_zip: '12345'
    #         }
    #       }
    #     }.to_json,
    #     headers: {} )

    # BackendService.update_address(@user.id, address_params)
    # expect(page).to have_content("330 Main Street")
    # expect(@user.address_line1).to eq '330 Main Street'
    # expect(page).to have_content("Joseph R. Biden")
    # expect(page.status_code).to eq 200
  end
end
