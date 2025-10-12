class UserMailer < ApplicationMailer
  default from: 'zubairghaffar.1046@gmail.com' 

  # ADD THIS METHOD FOR PASSWORD RESET
  def reset_password_instructions(user, token, opts = {})
    @user = user
    @token = token
    @reset_link = edit_user_password_url(reset_password_token: @token)

    mail(to: @user.email, subject: 'Reset your password')
  end
end