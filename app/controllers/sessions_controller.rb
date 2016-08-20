class SessionsController < ApplicationController
  def new
  end

  def show
  end

  def create
  	user = User.find_by(name: params[:user][:name])
  	password = params[:user][:password]

  	if user && user.authenticate(password)
  		session[:user_id] = user.id
  		redirect_to dashboard_path, notice: "Logged in successfully"
  	else
  		redirect_to login_path, alert: "Invalid username/password"
  	end
  end

  def destroy
  	reset_session
  	redirect_to login_path, notice: "You have been logged out"
  end
end
