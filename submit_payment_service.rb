require 'base64'
require 'time'
require 'uri'
require 'net/http'
require 'byebug'

require 'httparty'

class SubmitPaymentService
  def self.call(...)
    new.call(...)
  end

  def call(command)
    payment_payload = build_payment_payload(command)
    signature = OpenSSL::HMAC.hexdigest('SHA256', payment_payload, command.secret_key).upcase
    data = build_data(command, payment_payload, signature)
    payload = URI.encode_www_form([data])

    response = HTTParty.post 'https://demo2.2c2p.com/2C2PFrontEnd/SecurePayment/Payment.aspx',
                              pem: File.read('/usr/local/etc/openssl@1.1/cert.pem'),
                              body: { 'paymentRequest' => payload },
                              headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    byebug
    puts response.code, response.message, response.headers.inspect
    puts "body", response.body
  end

  private

  def build_data(command, payment_payload, signature)
    xml = "<PaymentRequest>
      <version>#{command.version}</version>
      <payload>#{payment_payload}</payload>
      <signature>#{signature}</signature>
    </PaymentRequest>"

    Base64.encode64 xml
  end

  def build_payment_payload(command)
    xml = "<PaymentRequest>
		  <merchantID>#{command.merchant_id}</merchantID>
		  <uniqueTransactionCode>#{command.unique_transaction_code}</uniqueTransactionCode>
		  <desc>#{command.desc}</desc>
		  <amt>#{command.amt}</amt>
		  <currencyCode>#{command.currency_code}</currencyCode>
		  <panCountry>#{command.pan_country}</panCountry>
		  <cardholderName>#{command.cardholder_name}</cardholderName>
		  <encCardData>#{command.enc_card_data}</encCardData>
		</PaymentRequest>"

    Base64.encode64 xml
  end
end