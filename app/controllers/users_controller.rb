class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create, :show]
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save 
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{current_user.username}!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    binding.pry
    @user.update(user_params) ? (redirect_to user_path(@user)) : (render :edit)
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end

end