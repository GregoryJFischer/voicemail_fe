class LettersController < ApplicationController

  def new
  end

  def create
     response = BackendService.post("letters", letter_params)
     confirmation = BackendService.parse_response(response)
     if confirmation.has_key?(:message)
       flash[:error] = confirmation[:message]
     elsif confirmation[:data][:attributes][:send_date]
       flash[:notice] = 'Your letter has been sent!'
       redirect_to "/dashboard"
     else
       flash[:error] = 'Error and error message not found'
  end

end
  private
    def letter_params
      user_id = session[:user_id]
      user_body = BackendService.get_user(user_id)
      user_attributes = user_body[:data][:attributes]

      rep_body = BackendService.representatives(user_id)

      #This line needs to be updated once we have our reps page up and running
      rep_attributes = rep_body[:data][11][:attributes]

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
        user_id: user_id,
        to_name: rep_attributes[:name],
        from_name: user_attributes[:name]
       }
    end
  end
