class Letter
  attr_reader :to_address_line1, :to_address_line2, :to_address_city, :to_address_state, :to_address_zip, :to_name,
              :from_address_line1, :from_address_line2, :from_address_city, :from_address_state, :from_address_zip, :user_id, :from_name,
              :body

  def initialize(rep_attributes, user_attributes, body)
    @to_address_line1 = rep_attributes[:attributes][:address_line1]
    @to_address_line2 = rep_attributes[:attributes][:address_line2]
    @to_address_city = rep_attributes[:attributes][:address_city]
    @to_address_state = rep_attributes[:attributes][:address_state]
    @to_address_zip = rep_attributes[:attributes][:address_zip]
    @to_name = rep_attributes[:attributes][:name]
    @from_address_line1 = user_attributes[:attributes][:address_line1]
    @from_address_line2 = user_attributes[:attributes][:address_line2]
    @from_address_city = user_attributes[:attributes][:address_city]
    @from_address_state = user_attributes[:attributes][:address_state]
    @from_address_zip = user_attributes[:attributes][:address_zip]
    @user_id = user_attributes[:id]
    @from_name = user_attributes[:attributes][:name]
    @body = body
  end

  def attributes
    {
      to_address_line1: @to_address_line1,
      to_address_line2: @to_address_line2,
      to_address_city: @to_address_city,
      to_address_state: @to_address_state,
      to_address_zip: @to_address_zip,
      from_address_line1: @from_address_line1,
      from_address_line2: @from_address_line2,
      from_address_city: @from_address_city,
      from_address_state: @from_address_state,
      from_address_zip: @from_address_zip,
      body: @body,
      user_id: @user_id,
      to_name: @to_name,
      from_name: @from_name
    }
  end
end
