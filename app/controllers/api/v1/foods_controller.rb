class Api::V1::FoodsController < ApplicationController
  before_action :find_food, only: [:destroy]
  def index
    if params[:status] == "available"
      @foods = Food.where(given_to: nil)
    elsif params[:shared_by] != nil
      @foods = Food.where(created_by: +params[:shared_by])
    elsif params[:receiver_id] != nil
      @foods = Food.where(given_to: params[:receiver_id])
    else
      @foods = Food.all
    end
    render json: {status:"success", data: {foods: @foods} }
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      render json: {status: 'success', data: {food: @food}}, status: :created
    else
      render json: {status: 'fail', error: {message: "Couldn't create user"}}, status: :unprocessable_entity
    end
  end

  def update
    favorites = Favorite.where(food_id: @food.id)
    claims = Claim.where(food_id: @food.id)

    claims.each do |claim|
      claim.destroy
    end

    favorites.each do |favorite|
      favorite.destroy
    end

    @food.update(food_params)

    render json: {status: "success", data: {food: @food}}
  end

  def destroy
    @food.destroy
  end

  private

  def food_params
    params.require(:food).permit(:name, :created_by, :description, :quantity)
  end

  def find_food
    @food = Food.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {status: "fail", error: {message: "Couldn't find food"}}, status: :not_found
  end
end
