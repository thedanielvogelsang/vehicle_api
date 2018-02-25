class Api::V1::VehiclesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Vehicle.order("RAND()").limit(100)
  end

  def show
    vehicle = Vehicle.exists?(params[:id])
    if vehicle
      render json: Vehicle.find(params[:id])
    else
      render status: 404
    end
  end

  def create
    vehicle = Vehicle.new(safe_params)
    if vehicle.save
      add_options
      render json: Vehicle.last, status: 201
    else
      render :json => {:error => 'bad-params'}.to_json, :status => 400
    end
  end

  def update
    vehicle = Vehicle.find(params[:id])
    if vehicle && !safe_params.to_h.empty? && vehicle.update(safe_params)
      vehicle.update(safe_params)
      add_options
      render json: Vehicle.last
    else
      render :json => {:error => 'bad-params'}.to_json, :status => 400
    end
  end

  def destroy
    Vehicle.destroy(params[:id])
    render :json => {:message => 'model deleted'}.to_json, :status => 204
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
