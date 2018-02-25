class Api::V1::VehiclesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Vehicle.order("RAND()").limit(100)
  end

  def show
    render json: Vehicle.find(params[:id])
  end

  def create
    vehicle = Vehicle.new(safe_params)
    if vehicle.save
      render json: Vehicle.last, status: 201
    elsif
      render :status => 400
    end
  end

  def update
    render json: Vehicle.all
  end

  def destroy
    render json: Vehicle.all
  end

  private
    def safe_params
      params.permit(:model_id, :make_id, :vin, :options_nums)
    end
end
