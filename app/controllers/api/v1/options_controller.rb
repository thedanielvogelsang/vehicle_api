class Api::V1::OptionsController < ApplicationController
  def index
    render json: Option.order("RAND()").limit(100)
  end

  def show
    option = Option.exists?(params["id"])
    if option
      render json: Option.find(params["id"])
    else
      render status: 404
    end
  end

  def create
    option = Option.new(safe_params)
    if option.save
      render json: Option.last, status: 201
    elsif
      render :json => {:error => "bad-params"}.to_json, :status => 400
    end
  end

  def update
    option = Option.find(params[:id])
    if option && !safe_params.to_h.empty? && options.update(safe_params)
      option.update(safe_params)
      render json: Option.last
    else
      render :json => {"error" => "bad-params"}, status: 400
    end
  end

  def destroy
    render json: Option.all
  end

  private
   def safe_params
      params.permit(:name, :description, :price, :promotion_code, :model_id)
   end
end
