class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update]
  def index
    if user_role == "all"
      @users = User.all
    else
      @users = User.where(role: user_role)
    end
    render json: {status: 'success', data: {users: @users}}
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {status: 'success', data: {user: @user}}, status: :created
    else
      render json: {status: 'fail', error: {message: "Couldn't create user"}}, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    render json: {status: "fail", error: {message: "A user with this email already exists."}}, status: :unprocessable_entity
  end

  def update
    @user.update(user_params)
    render json: {status: "success", data: {user: @user }}
  end

  def login
    @user = User.find_by({email: user_params[:email], password: user_params[:password]})
    if @user != nil
      render json: { status: "success", data: {user: @user}}
    else
      render json: {status: "fail", error: {mesage: "Invalid email or password"}}, status: :not_found
    end
  end

  private

  def user_role
    params.require(:role)
  end

  def user_params
    params.require(:user).permit(:name, :password, :role, :email, :address, :phone_number)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
