class Api::V1::FavoritesController < ApplicationController
  before_action :find_favorite, only: [:destroy]
  def index
    @favorites = Favorite.where({user_id: user_id, food_id: food_id})

    render json: {status:"success", data: {favorites: @favorites}}
  end

  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      render json: {status: "success", data: {favorite: @favorite}}, status: :created
    else
      render json: {status: "fail", error: {message: "Couldn't add favorite"}}, status: :unprocessable_entity
    end
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
