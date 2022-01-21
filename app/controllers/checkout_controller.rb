class CheckoutController < ApplicationController
  def create
    price = 99
    quantity = 1
  @session = Stripe::Checkout::Session.create({
    payment_method_types: ['card'],
    line_items: [{
      # name: 'Letter to Your Representative',
      price: "#{price}",
      currency: 'usd',
      quantity: "#{quantity}"
    }],
    mode: 'payment',
    success_url: "#{ENV['BASE_URL']}/dashboard.html",
    cancel_url: "#{ENV['BASE_URL']}/cancel.html"
  })

  respond_to do |format|
    format.js
  end
  end
end