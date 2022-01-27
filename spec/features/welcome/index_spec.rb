require 'rails_helper'

describe 'Welcome Page', :vcr do
  it 'can log a user in / log a user out' do
    visit root_path

    click_link('sign-in')

    expect(current_path).to eq dashboard_path

    click_link 'logout'

    expect(current_path).to eq root_path
  end

  it 'redirects back to root path if credentials are invalid' do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    visit root_path

    expect{ click_link('sign-in') }.to raise_error(OmniAuth::Error)
  end

  it 'redirects back to home path if unable to create a user' do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '123456789',
                                                                         info: {
                                                                           name: 'John Doe',
                                                                           email: nil,
                                                                           first_name: 'John',
                                                                           last_name: 'Doe',
                                                                           image: 'https://lh3.googleusercontent.com/url/photo.jpg'
                                                                         },
                                                                         credentials: {
                                                                           token: 'token',
                                                                           refresh_token: 'another_token',
                                                                           expires_at: 1_354_920_555,
                                                                           expires: true
                                                                         }
                                                                       })

    visit root_path
                                                                         
    click_link

    expect(current_path).to eq root_path
    expect(page).to have_content 'Could not create user. Please try again.'
  end

  it 'redirects to dashboard_path if the user is logged in' do
    user_params = { email: 'alexmmcconnell@gmail.com', name: 'Alex' }
    new_user = BackendService.find_or_create_user(user_params)
    session = { user_id: new_user[:data][:id] }

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)

    visit root_path

    expect(current_path).to eq dashboard_path
  end
end
