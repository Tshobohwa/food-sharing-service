class Api::V1::FoodsController < ApplicationController
  before_action :find_food, only: [:destroy]
  def index
    if params[:status] == "available"
      @foods = Food.where(given_to: nil)
    elsif params[:shared_by] != nil
      @foods = Food.where(created_by: +params[:shared_by])
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
