class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  skip_before_filter  :verify_authenticity_token

  def index
    render json: Payment.where(loan_id: params[:loan_id])
  end

  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      render json: @payment, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: set_payment
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.permit(:loan_id, :amount)
  end

end
