class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_admin_user_path, notice: "Added user, #{@user.firstname}"
    else
      render :page
    end
  end

  def show

  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.goodbye_email(@user).deliver_now
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def check_if_admin
    @user = User.find(session[:user_id]) if session[:user_id]
    unless @user.is_admin
      flash[:notice] = "You went to the wrong place so we sent you here!"
      redirect_to new_admin_user_path
    end
  end

  def user_params
    params.require(:user).permit(:email,:firstname, :lastname, :password, :password_confirmation, :is_admin)
  end

end