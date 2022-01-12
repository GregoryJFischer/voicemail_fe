require 'rails_helper'

describe LettersFacade do
  it 'can create a letter', :vcr do
    rep_attributes = { attributes: {
                                    :address_city=>"Denver",
                                    :address_line1=>"200 East Colfax Avenue",
                                    :address_state=>"CO",
                                    :address_zip=>"80203",
                                    :name=>"CO State Representative Alec Garnett"
                                  }
                      }
      body = 'test'
      confirmation = LettersFacade.create_letter(body, 1, rep_attributes)

      expect(confirmation).to be_a(Hash)
      expect(confirmation).to have_key(:data)
      expect(confirmation[:data][:id]).to eq("20")
      expect(confirmation[:data][:attributes][:send_date]).to eq("2022-01-11")
  end
end
