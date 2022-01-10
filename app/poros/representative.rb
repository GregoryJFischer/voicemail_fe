class Representative
  attr_reader :id,
              :name,
              :address_line1,
              :address_city,
              :address_state,
              :address_zip

  def initialize(rep)
    @name = rep[:attributes][:name]
    @address_line1 = rep[:attributes][:address_line1]
    @address_city  = rep[:attributes][:address_city]
    @address_state = rep[:attributes][:address_state]
    @address_zip   = rep[:attributes][:address_zip]
  end

  def set_id(integer)
    @id = integer
  end
end
