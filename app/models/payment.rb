class Payment < ApplicationRecord
  monetize :amount_cents
end
