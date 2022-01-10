class LettersController < ApplicationController
  def new
  end
  def create
     post "/api/v1/letters", params: user_params
     confirmation = JSON.parse(response.body, symbolize_names: true)
     if confirmation[:data][:attributes].has_key?(:send_date)
       @sent_letter_params = confirmation[:date][:attributes]
       redirect_to '/users/:id/letters'
     elsif confirmation.has_key?(:message)
       flash[:error] = confirmation[:message]
     else
       flash[:error] = 'Error and error message not found'
  end

end
  private
    def user_params
      user_id = session[:user_id]
      BackendService.get_user(user_id)
      binding.pry
      user_attributes = user_body[:data][:attributes]

      get "/api/v1/users/#{user.id}/representatives"
      rep_body = JSON.parse(response.body, symbolize_names: true)
      rep_attributes = rep_body[:data][:attributes]
      {
        to_address_line1: rep_attributes[:address_line1],
        to_address_line2: rep_attributes[:address_line2],
        to_address_city: rep_attributes[:address_city],
        to_address_state: rep_attributes[:address_state],
        to_address_zip: rep_attributes[:address_zip],
        from_address_line1: user_attributes[:address_line1],
        from_address_line2: user_attributes[:address_line2],
        from_address_city: user_attributes[:address_city],
        from_address_state: user_attributes[:address_state],
        from_address_zip: user_attributes[:address_zip],
        body: params[:body],
        user_id: user_attributes[:user_id],
        to_name: rep_attributes[:name],
        from_name: user_attributes[:name]
       }
    end
  end
