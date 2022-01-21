require 'rails_helper'

describe 'letters new', :vcr do
  before(:each) do
    user_params = { email: 'alexmmcconnell@gmail.com', name: 'Alex' }
    new_user = BackendService.find_or_create_user(user_params)
    session = { user_id: new_user[:data][:id] }

    address = {
      address_line1: '3431 N Vine St',
      address_city: 'Denver',
      address_state: 'CO',
      address_zip: '80205'
    }

    response = BackendService.update_address(new_user[:data][:id], address)
    @user = JSON.parse(response.body, symbolize_names: true)
    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)
  end

  it 'can show a new letter page' do
    rep_attributes = { attributes: {
      address_city: 'Denver',
      address_line1: '200 East Colfax Avenue',
      address_state: 'CO',
      address_zip: '80203',
      name: 'CO State Representative Alec Garnett'
    } }
    visit new_letter_path(rep_attributes)

    expect(page).to have_content('Sending letter to')
  end

  it 'allows you to fill out and send a letter' do
    rep_attributes = { attributes: {
      address_city: 'Denver',
      address_line1: '200 East Colfax Avenue',
      address_state: 'CO',
      address_zip: '80203',
      name: 'CO State Representative Alec Garnett'
    } }
    visit new_letter_path(rep_attributes)
    within('div.m-3') do
      fill_in :body, with: 'Senator Alec Garnett, Please make GrubHub free. Your other constituent, Alex'
    end
    click_button 'Create Letter'
    expect(current_path).to eq('/fetch_preview')
  end

  it 'doesnt accept the letter if the letter isnt filled out' do
    rep_attributes = { attributes: {
      address_city: 'Denver',
      address_line1: '200 East Colfax Avenue',
      address_state: 'CO',
      address_zip: '80203',
      name: 'CO State Representative Alec Garnett'
    } }
    visit new_letter_path(rep_attributes)

    click_button 'Create Letter'

    expect(current_path).to eq('/fetch_preview')
  end
end
