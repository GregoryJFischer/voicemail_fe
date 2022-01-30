class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, "#{ENV['TEST_SIGNING_SECRET']}"
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      stripe_session = event.data.object
      email = {email: params["data"]["object"]["customer_details"]["email"]}
      
      BackendService.post('letters/send', email)
    end

    render json: { message: 'success' }
  end
end