require 'rails_helper'

describe 'letters new' do
  before :each do
  end
  it 'can show a new letter page' do
    rep_attributes = { attributes: {
                                    :address_city=>"Denver",
                                    :address_line1=>"200 East Colfax Avenue",
                                    :address_state=>"CO",
                                    :address_zip=>"80203",
                                    :name=>"CO State Representative Alec Garnett"
                                  }
                      }
    visit new_letter_path(rep_attributes) do


    expect(page).to have_content("Sending letter to")
    end
  end
end
