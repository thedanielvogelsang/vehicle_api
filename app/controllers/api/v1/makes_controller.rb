class Api::V1::MakesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Make.all
  end

  def show
    make = Make.exists?(params['id'])
    if make
      render json: Make.find(params['id'])
    else
      render status: 404
    end
  end

  def create
    make = Make.new(safe_params)
    if make.save
      render json: Make.last, status: 201
    elsif
      render :json => {:error => "bad-params"}.to_json, :status => 400
    end
  end

  def update
    render json: Make.all
  end

  def destroy
    render json: Make.all
  end

  private
    def safe_params
      params.permit(:company, :company_desc, :company_motto, :ceo_statement)
    end
end
