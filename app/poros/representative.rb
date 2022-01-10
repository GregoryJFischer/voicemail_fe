class Representative
  attr_reader :id,
              :name,
              :address_line1,
              :address_city,
              :address_state,
              :address_zip

  def initialize(rep)
    @name = rep[1][0][:attributes][:name]
    @address_line1 = rep[1][0][:attributes][:address_line1]
    @address_city  = rep[1][0][:attributes][:address_city]
    @address_state = rep[1][0][:attributes][:address_state]
    @address_zip   = rep[1][0][:attributes][:address_zip]
  end

  def set_id(integer)
    @id = integer
  end
end
