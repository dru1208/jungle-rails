class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = @user.id
      redirect_to products_path, notice: 'Logged in'
    else
      redirect_to '/login', notice: 'Email/Password incorrect'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end