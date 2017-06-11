class Visa::CyberSource::Payment
  include Visa::CyberSource::InstanceMethods
  
  attr_accessor :amount, :card_number, :card_expiration_month, :card_expiration_year

  SUCCESS_STATUS = /20\d/

  def self.create(params)
    new(params).create
  end
  
  def initialize(params)
    @amount = params[:amount]
    @card_number = params[:card_number]
    @card_expiration_month = params[:card_expiration_month]
    @card_expiration_year =  params[:card_expiration_year]
  end
  
  def create
    is_success?
  end
  
  private
  
  def is_success?
    payment_response.code =~ SUCCESS_STATUS ? success_response : failed_response
  end
  
  def failed_response
    {
      payment_status: false,
      payment_payload: failed_payload
    }
  end
  
  def success_response
    {
      payment_status: true,
      payment_payload: success_payload
    }
  end
  
  def failed_payload
    payment_response_body[:responseStatus]
  end
  
  def success_payload
    payment_response_body
  end
  
  def payment_response_body
    JSON.parse(payment_response.body).with_indifferent_access
  end
  
  def payment_response
    create_payment.response
  end
  
  def create_payment
    HTTParty.post(full_request_url,
                  body: request_body,
                  headers: headers)
  end
  
  def request_body
    @request_body ||= {
                        amount: amount,
                        currency: "USD",
                        payment: {
                          cardNumber: card_number,
                          cardExpirationMonth: card_expiration_month,
                          cardExpirationYear:  card_expiration_year
                        }
                      }.to_json
  end
  
  def resource_path
    @resource_path ||= "payments/v1/sales".freeze
  end
  
  def hash_output
    @hash_output ||= OpenSSL::HMAC.hexdigest(digest,shared_secret,hash_input)
  end
  
  def hash_input
    @hash_input ||= timestamp + resource_path + query_string + request_body
  end

end