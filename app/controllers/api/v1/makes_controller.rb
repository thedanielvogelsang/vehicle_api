class Api::V1::MakesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Make.all
  end

  def show
    render json: Make.find(params['id'])
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
