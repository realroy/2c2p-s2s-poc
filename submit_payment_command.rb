class SubmitPaymentCommand
  attr_accessor :merchant_id,
                :secret_key,
                :desc,
                :unique_transaction_code,
                :currency_code,
                :amt,
                :pan_country,
                :cardholder_name,
                :enc_card_data,
                :version
end
