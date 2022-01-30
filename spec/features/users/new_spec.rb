require 'rails_helper'

describe 'register page', :vcr do
  it 'can create a user with password' do
    visit '/register'

    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: "#{Faker::Internet.unique.email}"
    fill_in 'Password', with: "password"
    fill_in 'Confirm Your Password', with: "password"

    click_button 'Create Account'

    expect(current_path).to eq '/dashboard'

    expect(page).to have_content 'Bob'
  end

  it 'gives an error if the email is taken' do
    visit '/register'

    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: "#{Faker::Internet.unique.email}"
    fill_in 'Password', with: "password"
    fill_in 'Confirm Your Password', with: "password"

    click_button 'Create Account'

    expect(current_path).to eq '/dashboard'

    expect(page).to have_content 'Bob'
  end

  it 'gives an error if the password and confirmation do not match' do
    visit '/register'

    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: "#{Faker::Internet.unique.email}"
    fill_in 'Password', with: "password"
    fill_in 'Confirm Your Password', with: "drowssap"

    click_button 'Create Account'

    expect(current_path).to eq '/register'

    expect(page).to have_content 'Password and confirmation do not match'
  end

  it 'gives an error if the email has been taken' do
    visit '/register'

    email = Faker::Internet.unique.email

    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: email
    fill_in 'Password', with: "password"
    fill_in 'Confirm Your Password', with: "password"

    click_button 'Create Account'

    expect(current_path).to eq '/dashboard'

    click_link 'logout'

    visit '/register'

    fill_in 'Name', with: 'Bob'
    fill_in 'Email', with: email
    fill_in 'Password', with: "password"
    fill_in 'Confirm Your Password', with: "password"

    click_button 'Create Account'

    expect(page).to have_content 'Email has already been registered'
  end

  it 'redirects to the dashboard if logged in' do
    email = Faker::Internet.unique.email
    user_params = {email: email, name: 'Alex'}
    new_user = BackendService.find_or_create_user(user_params)
    session = {user_id: new_user[:data][:id]}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(session)

    visit '/register'

    expect(current_path).to eq dashboard_path
  end
end