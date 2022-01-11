require 'rails_helper'

describe LettersFacade do
  it 'can create a letter', :vcr do

      body = 'test'
      confirmation = LettersFacade.create_letter(body, 1)

      expect(confirmation).to be_a(Hash)
      expect(confirmation).to have_key(:data)
      expect(confirmation[:data][:id]).to eq("15")
      expect(confirmation[:data][:attributes][:send_date]).to eq("2022-01-11")
  end
end
