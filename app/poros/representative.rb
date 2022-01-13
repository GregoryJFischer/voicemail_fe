class Representative
  attr_reader :id,
              :name,
              :title,
              :address_line1,
              :address_city,
              :address_state,
              :address_zip

  def initialize(rep)
    @name          = rep[:attributes][:name]
    @title         = rep[:attributes][:title]
    @address_line1 = rep[:attributes][:address_line1]
    @address_city  = rep[:attributes][:address_city]
    @address_state = rep[:attributes][:address_state]
    @address_zip   = rep[:attributes][:address_zip]
  end

  def attributes
    wip = {attributes: {
    id: nil,
    name: @name,
    address_line1: @address_line1,
    address_city: @address_city,
    address_state: @address_state,
    address_zip: @address_zip
    }}
  end
end
