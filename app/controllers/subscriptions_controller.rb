class SubscriptionsController < ApplicationController
  def new
    authorize! :read, @subscription, message: "To order our Premium Service, make sure you sign up and confirm your email address!"
    plan = Plan.find(1) # Hardcoding this for now, since only one plan
    @subscription = plan.subscriptions.build
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
end
