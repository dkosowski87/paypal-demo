module Payments
  class Done < BaseService
    def initialize(client: Paypal.new)
      @client = client
    end

    def call(data)
      form = DoneForm.new(data)
      return Status.failed(form.errors) unless form.valid?

      payment_data = execute_payment(form.payment_id, form.payer_id)
      persist_payment(payment_data)
      Status.success
    end

    private

    attr_reader :client

    def execute_payment(payment_id, payer_id)
      client.execute_payment(payment_id, payer_id)
    end

    def persist_payment(payment_data)
      Payment.create(
        amount: payment_data.transactions.first.amount.total,
        payment_method: payment_data.payer.payment_method
      )
    end
  end
end
