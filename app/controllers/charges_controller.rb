class ChargesController < ApplicationController

 def create
   # Creates a Stripe Customer object, for associating
   # with the charge
   customer = Stripe::Customer.create(
     email: current_user.email,
     card: params[:stripeToken]
   )
 
   # Where the real magic happens
   charge = Stripe::Charge.create(
     customer: customer.id, # Note -- this is NOT the user_id in your app
     amount: 10_00, #Amount.default
     description: "Blocipedia Premium - #{current_user.email}",
     currency: 'usd'
   )
 
   current_user.update_attribute(:role, 'premium')
   
   flash[:notice] = "Enjoy Blocipedia Premium, #{current_user.email}!"
   redirect_to root_path
 
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
 end
 
 def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium - #{current_user.email}",
     amount: 10_00 #Amount.default
   }
 end
 
 def cancel
    #If Stripe subscription model, then use below:
    #subscription = Stripe::Subscription.retrieve({SUBSCRIPTION_ID})
    #subscription.delete
   
    current_user.update_attribute(:role, 'standard')
    current_user.wikis.where(private: true).update_all(private: false)
   
    flash[:notice] = "Standard Membership enabled: Private wikis now Public"
    redirect_to root_path
 end
end
