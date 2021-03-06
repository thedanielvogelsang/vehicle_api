class Api::V1::ModelsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
    render json: Model.all
  end

  def show
    model = Model.exists?(params[:id])
    if model
      render json: Model.find(params[:id])
    else
      render status: 404
    end
  end


  def create
    model = Model.new(safe_params)
    if model.save
      render json: Model.last, status: 201
    else
      render :json => {:error => "bad-params"}.to_json, :status => 400
    end
  end


  def update
    model = Model.find(params[:id])

    if model && !safe_params.to_h.empty? && model.update(safe_params)
      model.update(safe_params)
      render json: Model.last
    else
      render :json => {:error => 'bad-params'}.to_json, :status => 400
    end
  end

  def destroy
    model = Model.find(params[:id])
    if model
      Model.destroy(params[:id])
      render :json => {:message => 'model deleted'}.to_json, :status => 204
    else
      render :json => {:message => 'model not found'}.to_json, :status => 400
    end
  end

  private
    def safe_params
      params.permit(:make_id, :name, :year_id)
    end
end
