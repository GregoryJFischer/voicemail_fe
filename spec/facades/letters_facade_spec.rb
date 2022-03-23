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

    address_params = {
      address_line1: '12012 starboard dr',
      address_line2: 'apt 205',
      address_city: 'reston',
      address_state: 'va',
      address_zip: '20194'
     }

    body = 'test'

    email = Faker::Internet.unique.email

    user = BackendService.find_or_create_user({email: email, name: 'Greg'})
   
    BackendService.update_address(user[:data][:id], address_params)

    letter = LettersFacade.create_letter(body, user[:data][:id], rep_attributes)

    response = BackendService.post('letters/send', {email: email})

    confirmation = JSON.parse(response.body, symbolize_names: true)

    expect(confirmation).to be_a(Hash)
    expect(confirmation).to have_key(:data)
    expect(confirmation[:data]).to have_key(:id)
    expect(confirmation[:data][:attributes][:send_date]).to eq(Date.today.strftime('%Y-%m-%d')).or eq(Date.current.strftime('%Y-%m-%d'))
  end
end
