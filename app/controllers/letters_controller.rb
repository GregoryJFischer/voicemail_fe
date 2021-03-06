class LettersController < ApplicationController
  protect_from_forgery except: :preview
  def new
    @rep = Representative.new(params)
    @user = DashboardFacade.new(session[:user_id]).user
    @letter_format = letter_format
  end

  def preview
    if params[:commit] == 'Create Letter'
      if params[:body].blank?
        flash[:error] = "Please fill out the letter before sending."

        render js: "window.location='#{new_letter_path(rep_params)}'"
      else
        render js: "window.location='#{letters_confirmation_path(params[:body], rep_params)}'"
      end
    end
  end

  def confirmation
    params[:body] ||= params[:format]
    confirmation = LettersFacade.preview_letter(params[:body], session[:user_id], rep_preview_params)
    @preview_url = confirmation[:data][:attributes][:preview_url]
    @delivery_date = DateTime.parse(confirmation[:data][:attributes][:delivery_date]).strftime("%B %e, %Y")
    sleep(3)
  end

  private

  def letter_format
    "Dear #{@rep.title} #{@rep.name},\n\n\n\nYour constituent,\n\n#{@user.name}"
  end

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

  def rep_preview_params
    {
      attributes: {
        name: params[:attributes][:name],
        address_line1: params[:attributes][:address_line1],
        address_city: params[:attributes][:address_city],
        address_state: params[:attributes][:address_state],
        address_zip: params[:attributes][:address_zip]
      }
    }
  end
end
