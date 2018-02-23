class Api::V1::VehiclesController < ApplicationController
  def index
    render json: Vehicle.all
  end

  def show
    render json: Vehicle.all
  end

  def create
    render json: Vehicle.all
  end

  def update
    render json: Vehicle.all
  end

  def destroy
    render json: Vehicle.all
  end 
end
