require 'rails_helper'

describe 'users dashboard' do
  before :each do
    @user = User.create(email: 'bob@example.com', first_name: 'Bob', last_name: 'bob', street_address_1: '123 Main Street')
    @session = {user_id: @user.id, token: 'abcd', google_id: '12345'}

    allow_any_instance_of(ApplicationController).to receive(:session).and_return(@session)
  end

  it 'should say hello' do
    visit '/dashboard'

    expect(page).to have_content "Welcome, #{@user.first_name}"
  end
end