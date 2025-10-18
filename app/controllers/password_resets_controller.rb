class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(mail: params[:mail])

    if @user.present?
      # send email
      PasswordMailer.with(user: @user).reset.deliver_later
    end

    redirect_to root_path, notice: "If your email address exists in our database, you will receive a password recovery link at your email address in a few minutes."
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "The password reset link is invalid or has expired."
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "Your password has been reset successfully."
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
