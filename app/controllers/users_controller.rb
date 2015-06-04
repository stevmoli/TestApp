class UsersController < ApplicationController
  before_filter :get_user, :only => [:edit, :update, :destroy]
  before_filter :check_user_authentication, :only => [:edit, :update, :destroy]

  def get_user
    @user = User.find(params[:id])
  end

  def check_user_authentication
    if (session[:user_id] != @user.id)
      flash[:notice] = "You can't delete other users' accounts."
      redirect_to :back   # this causes the page to reload with the flash message instead of taking you to the edit page
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #flash[:notice] = "Signed up"
      #redirect_to log_in_path

      session[:user_id] = @user.id; puts "*** Session: ***"; ap session[:user_id]
      flash[:notice] = "Signed up and logged in"
      redirect_to root_path
    else
      puts @user.errors.full_messages
      flash.now[:notice] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to log_out_path
  end

end
