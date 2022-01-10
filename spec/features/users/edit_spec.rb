require 'rails_helper'

describe 'user edit' do
  it "should be able to edit the user's address" do
    user = User.create(email: 'prisonmike@theoffice.com', name: 'Michael Scott')
    session = {user_id: user.id, token: 'abcd', google_id: '12345'}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)

    expect(user.street_address_1).to be nil

    visit '/edit'

    fill_in :address_line1, with: '123 Main Street'
    fill_in :address_city, with: 'city a'
    fill_in :address_state, with: 'state b'
    fill_in :address_zip, with: '12345'

    click_button

    user = User.find(session[:user_id])

    expect(current_path).to eq '/dashboard'

    expect(user.street_address_1).to eq '123 Main Street'

    # expect(page.status_code).to eq 200
    # expect(page).to have_content("Joseph R. Biden")
  end
end
