class UserBe
  attr_reader :user_id,
              :name,
              :email,
              :address_line1,
              :address_line2,
              :address_city,
              :address_state,
              :address_zip

  def initialize(info)
    @user_id = info[:data][:id]
    @name = info[:data][:attributes][:name]
    @email = info[:data][:attributes][:email]
    @address_line1 = info[:data][:attributes][:address_line1]
    @address_line2 = info[:data][:attributes][:address_line2]
    @address_city  = info[:data][:attributes][:address_city]
    @address_state = info[:data][:attributes][:address_state]
    @address_zip   = info[:data][:attributes][:address_zip]
  end

  def address
    if @address_line2.empty?
      @address_line1 + ' ' + @address_city + ', ' + @address_state + ' ' + @address_zip
    else
      @address_line1 + ' ' + @address_line2 + ' ' + @address_city + ', ' + @address_state + ' ' + @address_zip
    end
  end
end
