class User
  attr_reader :user_id,
              :name,
              :email,
              :address_line1,
              :address_line2,
              :address_city,
              :address_state,
              :address_zip

  def initialize(info)
    @user_id           = info[:data][:id]
    @name              = info[:data][:attributes][:name]
    @email             = info[:data][:attributes][:email]
    if info[:data][:attributes][:address]
      @address_line1   = info[:data][:attributes][:address][:address_line1]
      @address_line2   = info[:data][:attributes][:address][:address_line2]
      @address_city    = info[:data][:attributes][:address][:address_city]
      @address_state   = info[:data][:attributes][:address][:address_state]
      @address_zip     = info[:data][:attributes][:address][:address_zip]
    end
  end

  def address
    if @address_line2.empty?
      @address_line1 + ' ' + @address_city + ', ' + @address_state + ' ' + @address_zip
    else
      @address_line1 + ' ' + @address_line2 + ' ' + @address_city + ', ' + @address_state + ' ' + @address_zip
    end
  end

  def representatives
    representative_service.map do |rep|
      Representative.new(rep)
    end
  end
private

  def representative_service
    BackendService.representatives(user_id)[:data]
  end
end
