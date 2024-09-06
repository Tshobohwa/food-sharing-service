class Api::V1::UsersController < ApplicationController
  def index
    if user_role == "all"
      @user = User.all
    else
      @user = User.where(role: user_role)
    end
    render json: {status: 'success', data: {user: @user}}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {status: 'success', data: {user: @user}}, status: :created
    else
      render json: {status: 'fail', error: {message: "Couldn't create user"}}, status: :fail
    end
  end

  private

  def user_role
    params.require(:role)
  end

  def user_params
    params.require(:user).permit(:name, :password, :role, :email)
  end
end
