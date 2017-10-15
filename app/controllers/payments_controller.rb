class PaymentsController < ApplicationController
  def new
    render :new, locals: { payment: Payment.new }
  end

  def create
    result = Payments::Create.call(payment_params)
    result.on_success { |payment_link| redirect_to payment_link }
    result.on_failed { |error| redirect_to root_path, notice: error }
  end

  def done
    result = Payments::Done.call(params.permit!)
    result.on_success { redirect_to root_path, notice: 'Payment successful' }
    result.on_failed { |error| redirect_to root_path, notice: error }
  end

  def cancel
    redirect_to root_path, notice: 'Payment canceled'
  end

  private

  def payment_params
    params.require(:payment).permit!
  end
end
