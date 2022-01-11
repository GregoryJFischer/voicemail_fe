require 'rails_helper'

describe 'letters new' do
  before :each do
  end
  it 'can show a new letter page' do
    visit '/letters/new' do

    expect(page).to have_content("Create New Letter")
    end
  end
end
