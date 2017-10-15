module Payments
  class Create < BaseService
    def initialize(client: Paypal.new)
      @client = client
    end

    def call(data)
      form = CreateForm.new(data)
      return Status.failed(form.errors) unless form.valid?

      payment_data = create_payment(form.payment_data)
      payment_link = extract_payment_approval_url(payment_data)
      Status.success(payment_link)
    end

    private

    attr_reader :client

    def create_payment(data)
      client.create_payment(data)
    end

    def extract_payment_approval_url(data)
      data.links.find { |link| link.rel == 'approval_url' }.href    
    end
  end
end
