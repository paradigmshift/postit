class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:two_factor] = true
      user.two_factor_auth ? two_factor(user) : successful_login(user)
    else
      errored_out
    end
  end

  def successful_login(user)
    session[:user_id] = user.id
    flash[:notice] = "You've logged in!"
    user.destroy_pin!
    redirect_to root_path
  end

  def errored_out
    flash[:error] = "Something went wrong, please check your credentials and try again."
    redirect_to login_path
  end

  def two_factor(user)
    user.generate_pin!
    redirect_to pin_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

  def pin
    errored_out if !session[:two_factor]
    if request.post?
      user = User.find_by(pin: params[:pin])
      user.nil? ? errored_out : successful_login(user)
    end
  end

end
