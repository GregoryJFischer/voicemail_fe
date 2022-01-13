require 'rails_helper'

describe 'user edit' do
  it "cant access the page without being logged in" do
    visit '/edit'

    expect(page).to have_content('You must be logged in to visit this page')
    expect(current_path).to eq root_path
  end

  describe 'logged in user', :vcr do
    before(:each) do
      user_params = {email: 'alexmmcconnell@gmail.com', name: 'Alex'}
      new_user = BackendService.find_or_create_user(user_params)
      session = {user_id: new_user[:data][:id]}

      allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)
    end

    it "can edit the user's address without an address line 2" do
      visit '/edit'

      fill_in :address_line1, with: '3431 N Vine St'
      fill_in :address_line2, with: ''
      fill_in :address_city, with: 'Denver'
      fill_in :address_state, with: 'CO'
      fill_in :address_zip, with: '80205'

      click_button "Save"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("3431 N Vine St Denver, CO 80205")
    end

    it "can edit the user's address with an address line 2" do
      visit '/edit'

      fill_in :address_line1, with: '12012 Starboard Dr'
      fill_in :address_line2, with: 'Apt 205'
      fill_in :address_city, with: 'Reston'
      fill_in :address_state, with: 'VA'
      fill_in :address_zip, with: '20194'

      click_button "Save"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("12012 Starboard Dr Apt 205 Reston, VA 20194")
    end

    it 'doesnt edit the address if all parameters arent filled out' do
      visit '/edit'

      fill_in :address_line1, with: ''
      fill_in :address_city, with: ''
      fill_in :address_state, with: ''
      fill_in :address_zip, with: ''

      click_button "Save"

      expect(current_path).to eq('/edit')

      expect(page).to have_content("Address invalid; please make sure all fields are filled in and correct.")
    end
  end
end
