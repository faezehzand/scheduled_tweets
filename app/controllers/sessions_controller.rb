class SessionsController < ApplicationController
  def new
  end

  def create
    user= User.find_by(mail: params[:mail])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
