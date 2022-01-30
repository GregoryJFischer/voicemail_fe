require 'rails_helper'

describe LettersFacade do
  it 'can create a letter', :vcr do
    rep_attributes = { attributes: {
      address_city: 'Denver',
      address_line1: '200 East Colfax Avenue',
      address_state: 'CO',
      address_zip: '80203',
      name: 'CO State Representative Alec Garnett'
    } }
    body = 'test'
    letter = LettersFacade.create_letter(body, 1, rep_attributes)

    email = {email: 'nathan.brown263@gmail.com'}
      
    response = BackendService.post('letters/send', email)

    confirmation = JSON.parse(response.body, symbolize_names: true)

    expect(confirmation).to be_a(Hash)
    expect(confirmation).to have_key(:data)
    expect(confirmation[:data]).to have_key(:id)
    expect(confirmation[:data][:attributes][:send_date]).to eq(Date.today.strftime('%Y-%m-%d')).or eq(Date.current.strftime('%Y-%m-%d'))
  end
end
