class Api::V1::ModelsController < ApplicationController
  def index
    render json: Model.all
  end

  def show
    render json: Model.find(params[:id])
  end


  def create
    model = Model.new(safe_params)
    if model.save
      render json: Model.last, status: 201
    elsif
      render :json => {:error => "bad-params"}.to_json, :status => 400
    end
  end


  def update
    render json: Model.all
  end

  def destroy
    render json: Model.all
  end

  private
    def safe_params
      params.permit(:make_id, :name, :year_id)
    end
end
