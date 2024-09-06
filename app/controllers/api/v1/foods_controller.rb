class Api::V1::FoodsController < ApplicationController
  def index
    @foods = Food.all

    render json: {status:"success", data: {foods: @foods} }
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      render json: {status: 'success', data: {food: @food}}, status: :created
    else
      render json: {status: 'fail', error: {message: "Couldn't create user"}}, status: :fail
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :created_by, :description, :quantity)
  end
end
