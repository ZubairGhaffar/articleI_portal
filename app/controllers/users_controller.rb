# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  
def profile
  @user = current_user
  @articles = current_user.articles.order(created_at: :desc)
  # Ensure avatar is loaded
  @user.avatar.attach(current_user.avatar.blob) if current_user.avatar.attached?
end

  def public_profile
    @user = User.includes(avatar_attachment: :blob).find(params[:id])
    @articles = @user.articles.published.order(created_at: :desc)
    
    # If the user is viewing their own profile, redirect to the regular profile page
    if current_user == @user
      redirect_to profile_path and return
    end
  end
end