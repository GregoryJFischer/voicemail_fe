class CheckoutController < ApplicationController
  def create
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price: "price_1KLZM1DoriRctdfdx4PS1wKD",
        quantity: 1
      }],
      mode: 'payment',
      success_url: "#{ENV['FRONTEND_URL']}/dashboard.html?sent=true",
      cancel_url: "#{ENV['FRONTEND_URL']}/dashboard.html"
    })

    respond_to do |format|
      format.js
    end
  end
end