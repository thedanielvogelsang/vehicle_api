class Api::V1::ModelsController < ApplicationController
  def index
    render json: Model.all
  end

  def show
    render json: Model.find(params[:id])
  end

  def create
    render json: Model.all
  end

  def update
    render json: Model.all
  end

  def destroy
    render json: Model.all
  end
end
