require 'rails_helper'

describe 'users dashboard' do
  describe 'user logged in' do
    before :each do
      @user = User.new(user_data_no_address)
      @session = { user_id: @user.user_id, token: 'abcd', google_id: '12345' }
      allow_any_instance_of(ApplicationController).to receive(:session).and_return(@session)
      allow(BackendService).to receive(:get_user).with('1').and_return(user_data_no_address)
    end

    it 'should say hello' do
      visit '/dashboard'

      expect(page).to have_content "Welcome, #{@user.name}"
    end

    it 'should have a button to add a return address', :vcr do
      visit '/dashboard'

      expect(page).to have_button 'Add a valid return address to see your representatives'

      click_button 'Add a valid return address to see your representatives'

      expect(current_path).to eq('/edit')
    end
    
    it 'tells them they sent a letter', :vcr do
      visit '/dashboard?sent=true'

      expect(page).to have_content('Your letter has been sent!')
    end
  end


  describe 'user not logged in' do
    it 'redirects user to root path', :vcr do
      visit '/dashboard'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must be logged in to visit this page')
    end
  end


end
