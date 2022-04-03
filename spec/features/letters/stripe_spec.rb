  require 'rails_helper'

describe 'Stripe checkout', type: :system do
  before(:each) do
    @user_params = { email: Faker::Internet.unique.email, name: 'Alex' }
    new_user = BackendService.find_or_create_user(@user_params)
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

    expect(current_path).to include('/letters')

    click_button('Confirm Letter and Pay')

    wait_for_pageload('.ProductSummary')
  end

  it 'sends letter with valid email' do
    fill_in :email, with: @user_params[:email]
    fill_in :cardNumber, with: "4242424242424242"
    fill_in :cardExpiry, with: "0125"
    fill_in :cardCvc, with: "999"
    fill_in :billingName, with: "John Doe"
    fill_in :billingPostalCode, with: "90210"

    click_button "Pay"

    expect(page).to have_content("Processing")
  end
end