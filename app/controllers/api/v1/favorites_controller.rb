class Api::V1::FavoritesController < ApplicationController
  before_action :find_favorite, only: [:destroy]
  def index
    if params[:user_id] != nil
      @favorites = Favorite.includes(:user, :food).where(user_id: params[:user_id])
    elsif params[:food_id] != nil
      @favorites = Favorite.includes(:user, :food).where(food_id: params[:food_id])
    else
      @favorites = Favorite.all
    end

    render json: {status:"success", data: {favorites: @favorites}}
  end

  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      render json: {status: "success", data: {favorite: @favorite}}, status: :created
    else
      render json: {status: "fail", error: {message: "Couldn't add favorite"}}, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    render json: {status: "fail", error: "Favorite already exists"}, status: :unprocessable_entity
  end

  def destroy
    @favorite.destroy
  end

  private
  def food_id
    request.params[:food_id]
  end

  def user_id
    request.params[:user_id]
  end

  def favorite_params
    params.require(:favorite).permit(:user_id, :food_id)
  end

  def find_favorite
    @favorite = Favorite.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {status: "fail", error: { message: "Couldn't find favorite" } }, status: :not_found
  end
end
