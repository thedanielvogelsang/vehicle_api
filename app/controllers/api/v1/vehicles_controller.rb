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
      add_options
      render json: Vehicle.last, status: 201
    elsif
      render :json => {:error => 'bad-params'}.to_json, :status => 400
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
      params.permit(:model_id, :make_id, :vin)
    end

    def add_options
      add_opt = params[:options_nums]
      add_opt ? OptionAdder.new(add_opt) : nil
    end
end
