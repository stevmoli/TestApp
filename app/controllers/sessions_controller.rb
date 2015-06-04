class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged In"
      redirect_to root_path
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    unless User.exists?(:id => session[:user_id])  # if we are deleting an account (we are checking if the user_id of the current session still belongs to an existing user)
      session[:user_id] = nil
      redirect_to root_url, :notice => "Your account and all posts associated with it have been deleted."
    else # if it is a normal logout
      session[:user_id] = nil
      redirect_to root_url, :notice => "Logged out!"
    end
  end
end
