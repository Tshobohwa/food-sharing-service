class Api::V1::ClaimsController < ApplicationController
  before_action :find_claim, only: [:destroy]
  def index
    if params[:user_id] != nil
      @claims = Claim.includes(:user, :food).where(user_id: params[:user_id])
    elsif params[:food_id] != nil
      @claims = Claim.includes(:user, :food).where(food_id: params[:food_id])
    else
      @claims = Claim.all
    end

    render json: {status: "success", data: {claims: @claims.as_json(includes: [:user, :food])}}
  end

  def create
    food = Food.find(claim_params[:food_id])
    render json: {status:"fail", error: {message: "Food already given"}}, status: :unprocessable_entity if food[:given_to] != nil

    @claim = Claim.new(claim_params)
    if @claim.save
      render json: {status: "success", data: {claim: @claim}}, status: :created
    else
      render json: {status: "fail", error: {message: "Couldn't add claim"}}, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotUnique
    render json: {status: "fail", error: "Claim already exists"}, status: :unprocessable_entity
  end


  def destroy
    @claim.destroy
  end

  private

  def claim_params
    params.require(:claim).permit(:food_id, :user_id)
  end

  def find_claim
    @claim = Claim.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {status: "fail", error: { message: "Couldn't find claim" } }, status: :not_found
  end
end
