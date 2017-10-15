class Paypal
  RETURN_URL = "http://#{AppConfig.app_host}/payments/done".freeze
  CANCEL_URL = "http://#{AppConfig.app_host}/payments/cancel".freeze

  class RequestFailed < StandardError; end

  def create_payment(data)
    request_body = build_request_body(data)
    payment = PayPal::SDK::REST::Payment.new(request_body)
    raise RequestFailed unless payment.create
    payment
  end

  def execute_payment(payment_id, payer_id)
    payment = PayPal::SDK::REST::Payment.find(payment_id)
    raise RequestFailed unless payment.execute(payer_id: payer_id)
    payment
  end

  private

  def build_request_body(data)
    data.merge(redirect_urls)
  end

  def redirect_urls
    { redirect_urls: { return_url: RETURN_URL, cancel_url: CANCEL_URL } }
  end
end
