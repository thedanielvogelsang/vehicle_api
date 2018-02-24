class Api::V1::OptionsController < ApplicationController
  def index
    render json: Option.order("RAND()").limit(100)
  end

  def show
    render json: Option.find(params["id"])
  end

  def create
    render json: Option.all
  end

  def update
    render json: Option.all
  end

  def destroy
    render json: Option.all
  end
end
