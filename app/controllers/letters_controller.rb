class LettersController < ApplicationController
  protect_from_forgery except: :preview
  def new
    @rep = Representative.new(params)
  end

  def preview
    if params[:commit] == 'Create Letter'
      confirmation = LettersFacade.create_letter(params[:body], session[:user_id], rep_params)
      if confirmation.has_key?(:message)
        flash[:error] = confirmation[:message]
        render js: "window.location='#{new_letter_path(rep_params)}'"
      elsif confirmation[:data][:attributes][:send_date]
        flash[:notice] = 'Your letter has been sent!'
        render js: "window.location='/dashboard'"
      end
    else
      confirmation = LettersFacade.create_letter(params[:body], session[:user_id], rep_params)
      @preview_url = confirmation[:data][:attributes][:preview_url]
      @delivery_date = confirmation[:data][:attributes][:delivery_date]
      sleep(3)
    end
  end

  private

  def rep_params
    {
      attributes: {
        name: params[:rep_name],
        address_line1: params[:rep_address_line1],
        address_city: params[:rep_address_city],
        address_state: params[:rep_address_state],
        address_zip: params[:rep_address_zip]
      }
    }
  end
end
