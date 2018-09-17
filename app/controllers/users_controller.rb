class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    lower_case_email = @user.email.strip.downcase
    @user.email = lower_case_email
    if @user.save
      session[:user_id] = @user.id
      redirect_to products_path
    else
      redirect_to '/register'
    end
  end


  private
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password)
    end
end

