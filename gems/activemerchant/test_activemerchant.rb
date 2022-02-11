

require 'active_merchant'

# use the trustcommerce 
ActiveMerchant::Billing::Base.mode = :test

gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
                                                           :login => "TestMerchant",                   
                                                            :password => 'password')
gateway = ActiveMerchant::Billing::StripeGateway.new(:login=>"sk_test_mkGsLqEW6SLnZa487HYfJVLf");

gateway = ActiveMerchant::Billing::PaypalGateway.new(
                                                     :login=>"",
                                                     :password =>"", 
                                                     :signature => "")
# accept all mount as integer.  unit is cents
amount = 1000

# card verification value is also known as CVV2, CVC2, or CID
credit_card = ActiveMerchant::Billing::CreditCard.new(
                                                      :first_name         => 'Bob',
                                                      :last_name          => 'Bobsen',
                                                      :number             => '4242424242424242',
                                                      :month              => '8',
                                                      :year               => Time.now.year+1,
                                                      :verification_value => '000')


# validating the card automatically detects the card tpye
if credit_card.valid?
  # capture $10
  response = gateway.purchase(amount, credit_card)

  if response.success?
    puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
  else
    raise StandardError, response.message
  end
end



