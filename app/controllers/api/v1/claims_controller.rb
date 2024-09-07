class Api::V1::ClaimsController < ApplicationController
  before_action :find_claim, only: [:destroy]
  def index
    if params[:user_id] != nil
      @claims = Claim.where(user_id: params[:user_id])
    elsif params[:food_id] != nil
      @claims =Claim.where(food_id: params[:food_id])
    else
      @claims = Claim.all
    end

    render json: {status: "success", data: {claims: @claims}}
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
