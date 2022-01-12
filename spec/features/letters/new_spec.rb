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

  it 'allows you to fill out and send a letter' do
    rep_attributes = { attributes: {
                                    :address_city=>"Denver",
                                    :address_line1=>"200 East Colfax Avenue",
                                    :address_state=>"CO",
                                    :address_zip=>"80203",
                                    :name=>"CO State Representative Alec Garnett"
                                  }
                      }
      visit new_letter_path(rep_attributes) do

      fill_in :body, with: "Senator Michael Bennet, Please make GrubHub free. Your other constituent, Alex"
      click_button "Submit"

      expect(current_path).to eq("/letters")
    end
  end

  it 'doesnt accept the letter if the letter isnt filled out' do
    rep_attributes = { attributes: {
                                    :address_city=>"Denver",
                                    :address_line1=>"200 East Colfax Avenue",
                                    :address_state=>"CO",
                                    :address_zip=>"80203",
                                    :name=>"CO State Representative Alec Garnett"
                                  }
                      }
      visit new_letter_path(rep_attributes) do
      click_button "Submit"

      expect(current_path).to eq(new_letter_path(rep_attributes))
    end
  end
end
