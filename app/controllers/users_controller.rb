class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You are registered."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end

  end

  def show
    @user = User.find_by(slug: params[:id])
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(params[:user_id])

  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
