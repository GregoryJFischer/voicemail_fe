require 'rails_helper'

describe 'log in page', :vcr do
  before :each do
    visit '/register'

    @email = Faker::Internet.unique.email

    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: @email
    fill_in 'Password', with: "password"
    fill_in 'Confirm Your Password', with: "password"

    click_button 'Create Account'

    click_link 'logout'
  end

  it 'can log a user in succesfully' do
    expect(current_path).to eq root_path

    click_link 'Log In With Email'

    fill_in 'Email', with: @email
    fill_in 'Password', with: "password"

    click_button 'Log In'

    expect(current_path).to eq '/dashboard'
    expect(page).to have_content 'Welcome, Bob'
  end

  it 'gives an error if no fields are filled in' do
    expect(current_path).to eq root_path

    click_link 'Log In With Email'

    click_button 'Log In'

    expect(current_path).to eq '/login'
    expect(page).to have_content 'Invalid Credentials'
  end

  it 'gives an error if the password is incorrect' do
    expect(current_path).to eq root_path

    click_link 'Log In With Email'

    fill_in 'Email', with: @email
    fill_in 'Password', with: "drowssap"

    click_button 'Log In'

    expect(current_path).to eq '/login'
    expect(page).to have_content 'Invalid Credentials'
  end

  it 'gives an error if email is incorrect' do
    expect(current_path).to eq root_path

    click_link 'Log In With Email'

    fill_in 'Password', with: "password"

    click_button 'Log In'

    expect(current_path).to eq '/login'
    expect(page).to have_content 'Invalid Credentials'
  end

  it 'when logged in it redirects to the dashboard' do
    email = Faker::Internet.unique.email
    user_params = {email: email, name: 'Alex'}
    new_user = BackendService.find_or_create_user(user_params)
    session = {user_id: new_user[:data][:id]}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)

    visit '/login'

    expect(current_path).to eq dashboard_path
  end
end