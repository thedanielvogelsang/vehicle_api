class Api::V1::MakesController < ApplicationController
  def index
    render json: Make.all
  end

  def show
    render json: Make.find(params['id'])
  end

  def create
    render json: Make.all

  end

  def update
    render json: Make.all
  end

  def destroy
    render json: Make.all
  end
end
