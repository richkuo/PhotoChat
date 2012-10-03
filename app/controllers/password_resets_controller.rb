class PasswordResetsController < ApplicationController
  def new
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 3.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired. Please reset your password within 3 hours of request. Thank you"
    end
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_path, :notice => "An email as been sent with password reset instructions. Please check your email (and spam folder)"
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to new_session_path
      flash[:success] = "Password successfully reset! Please sign in with your new password."
    else
      render :edit
    end
  end
end
