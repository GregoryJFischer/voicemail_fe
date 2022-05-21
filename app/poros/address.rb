class Address
  attr_reader :address_line1,
              :address_line2,
              :address_city,
              :address_state,
              :address_zip

  def initialize(info)
    @address_line1 = info[:data][:attributes][:address_line1]
    @address_line2 = info[:data][:attributes][:address_line2]
    @address_city  = info[:data][:attributes][:address_city]
    @address_state = info[:data][:attributes][:address_state]
    @address_zip   = info[:data][:attributes][:address_zip]
  end
end