class SessionsController < ApplicationController

  def new
    
  end

  def create    
    user = User.find_by(username: params[:username])
    if (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Login failed.  Please check your username and password."
      render :new
    end
  end

  def destroy
    if session[:user_id] != nil
      session[:user_id] = nil
      flash[:notice] = "You have been logged out."
      redirect_to root_path
    else
      flash[:notice] = "You cannot log out that which has not been logged in."
      redirect_to root_path
    end
  end

end