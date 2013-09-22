class UsersController < ApplicationController
  def new
    if Rails.env.development?
      @user = FactoryGirl.build(:user)
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to restaurants_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone, :owner)
  end

end