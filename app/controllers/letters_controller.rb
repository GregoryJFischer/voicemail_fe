class LettersController < ApplicationController
  def new
    @rep = Representative.new(params)
  end

  def create
    confirmation = LettersFacade.create_letter(params[:body], session[:user_id], rep_params)
    if confirmation.has_key?(:message)
      flash[:error] = confirmation[:message]
      redirect_to new_letter_path(rep_params)
    else confirmation[:data][:attributes][:send_date]
      flash[:notice] = 'Your letter has been sent!'
      redirect_to "/dashboard"
    end
  end

private

  def rep_params
    { attributes: {
      name: params[:rep_name],
      address_line1: params[:rep_address_line1],
      address_city: params[:rep_address_city],
      address_state: params[:rep_address_state],
      address_zip: params[:rep_address_zip]
    } }
  end
end
