require_relative './submit_payment_command'
require_relative './submit_payment_service'

command = SubmitPaymentCommand.new

command.merchant_id = 'JT01'
command.secret_key = '7jYcp4FxFdf0'
command.desc = '2 days 1 night hotel room'
command.unique_transaction_code = Time.now.to_i
command.currency_code = '702'
command.amt = '000000000010'
command.pan_country = 'SG'
command.cardholder_name = 'John Doe'
command.version = '9.9'
command.enc_card_data = '00acE73+cAknCOHRxvaqzGG4PfQkGASr7ySWH+qjZA1PIihtRHN2eTp6lRRQYRDfot7J6WnLZhXDg52VbSQ4SKilrqtGxd3LPMCFR6X6PVjltj3uDzO5L44kg/V7Lu52xgFRArMaG0L5L7fYxk0Hd3Fn8Xd3Mer76Km1heBSr1MDbBM=U2FsdGVkX1/7qsKZv0W737WpbN8Dm/HAYgxtPRZ3DnqwRuk8ERogjoOnW5Sq3iok'

SubmitPaymentService.call command
