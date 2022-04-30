# frozen_string_literal: true

class Api::V1::StocksController < Api::V1::ApplicationController
  before_action :find_stock!, only: %i[show update destroy]

  def index
    @stocks = Stock.includes(:bearer).without_deleted
  end

  def create
    ActiveRecord::Base.transaction(requires_new: true) do
      bearer = Bearer.find_or_create_by!(name: params.dig(:bearer, :name))

      @stock = Stock.new(name: params[:name], bearer: bearer)
      @success = @stock.save!
    end

    render :show, status: :created
  end

  def show; end

  def update
    @stock.update!(name: params[:name])

    render :show, status: :ok
  end

  def destroy
    @stock.update(deleted_at: Time.current)

    render json: { message: '' }, status: :ok
  end

  private

  def find_stock!
    @stock = Stock.without_deleted.find_by(id: params[:id])

    raise ActiveRecord::RecordNotFound, "Stock with id: #{params[:id]} doesn't exists." unless @stock

  rescue ActiveRecord::RecordNotFound => e
    render_error(:stock, [e], :unprocessable_entity)
  end


  protected

  def render_error(entity, messages, status)
    render json: { entity: entity, errors: messages }, status: status
  end
end