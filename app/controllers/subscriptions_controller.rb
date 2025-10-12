class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    if current_user == @user
      redirect_to public_profile_user_path(@user), alert: "You cannot subscribe to yourself."
      return
    end

    @subscription = current_user.subscriptions.build(subscribed_to: @user)

    if @subscription.save
      # Send notification email to the author
      NotificationMailer.new_subscriber_notification(current_user, @user).deliver_later

      redirect_to public_profile_user_path(@user), notice: "Successfully subscribed to #{@user.name}"
    else
      redirect_to public_profile_user_path(@user), alert: @subscription.errors.full_messages.to_sentence
    end
  end




  def destroy
    @subscription = current_user.subscriptions.find_by(subscribed_to_id: @user.id)

    if @subscription&.destroy
      redirect_to public_profile_user_path(@user), notice: "Successfully unsubscribed from #{@user.name}"
    else
      redirect_to public_profile_user_path(@user), alert: "Could not unsubscribe from #{@user.name}"
    end
  end




  def index
    @subscribed_to_users = current_user.subscribed_to_users
  end

  private

  def set_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end
end
