class SubscriptionsController < ApplicationController
  def new
    if (current_user)
      if (Subscription.find_by user_id: current_user.id)
        # TODO: update redirect to premium user's wiki home page with a thank you alert
        redirect_to root_path, :notice => "You're already a subscriber!"
      else
        plan = Plan.monthly
        @subscription = plan.subscriptions.build
      end
    else # user is not logged in
      redirect_to new_user_registration_path, :alert => "To subscribe to our Premium Service, sign up and confirm your email address!"
    end
  end

  def create
    # @subscription = Subscription.new(params[:subscription]) # this appears to only work in rails < 4
    # http://stackoverflow.com/questions/17335329/activemodelforbiddenattributeserror-when-creating-new-user
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment(current_user)
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  private
  
  def subscription_params
    params.require(:subscription).permit(:plan_id, :stripe_card_token, :user_id)
  end

  def index
  end
end
