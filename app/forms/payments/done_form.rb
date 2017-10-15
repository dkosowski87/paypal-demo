module Payments
  class DoneForm < BaseForm
    attribute :paymentId, String
    attribute :PayerID, String

    validates :paymentId, :PayerID, presence: true

    alias_method :payment_id, :paymentId
    alias_method :payer_id, :PayerID
  end
end
