class CreditcardsController < ApplicationController
  def create
    # TODO
    # - creer un Stripe Customer a partir du stripe token
    customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
    )
    current_user.update(stripe_customer_id: customer.id, credit_card: customer.sources.data.first)
    redirect_to profile_path
  end
end
