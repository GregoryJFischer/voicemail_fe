class Representative
  attr_reader :id,
              :name,
              :title,
              :address_line1,
              :address_city,
              :address_state,
              :address_zip,
              :photo_url

  def initialize(rep)
    @name          = rep[:attributes][:name]
    @title         = rep[:attributes][:title]
    @address_line1 = rep[:attributes][:address_line1]
    @address_city  = rep[:attributes][:address_city]
    @address_state = rep[:attributes][:address_state]
    @address_zip   = rep[:attributes][:address_zip]
    @photo_url     = rep[:attributes][:photo_url] if rep[:attributes][:photo_url]
  end

  def attributes
    { attributes: {
      id: nil,
      name: @name,
      title: @title,
      address_line1: @address_line1,
      address_city: @address_city,
      address_state: @address_state,
      address_zip: @address_zip
    } }
  end
end
