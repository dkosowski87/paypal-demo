module Payments
  class CreateForm < BaseForm
    attribute :amount, String

    validates :amount, presence: true

    def payment_data
      {
        intent: 'sale',
        payer: { payment_method: 'paypal' },
        transactions: [{ amount: { total: amount, currency: 'EUR' } }],
        description: 'Registered payment'
      }
    end
  end
end
