class CheckoutController < ApplicationController
  def create
    letter = Stripe::Product.create(name: 'Letter')

    price = Stripe::Price.create(
      {
        product: "#{letter.id}",
        unit_amount: 99,
        currency: 'usd',
      }
    )

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price: "#{price.id}",
        quantity: 1
      }],
      mode: 'payment',
      success_url: "#{ENV['FRONTEND_URL']}/dashboard.html?sent=true",
      cancel_url: "#{ENV['FRONTEND_URL']}/letters/new.html"
    })

    respond_to do |format|
      format.js
    end
  end
end