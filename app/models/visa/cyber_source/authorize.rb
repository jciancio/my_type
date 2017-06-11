class Visa::CyberSource::Authorize  
  include Visa::CyberSource::InstanceMethods
  attr_accessor :amount, :card_number, :card_expiration_month, :card_expiration_year

  SUCCESS_STATUS = /20\d/

  def self.card(credit_card_params)
    new(credit_card_params).card
  end

  def initialize(params)
    @amount = params[:amount]
    @card_number = params[:card_number]
    @card_expiration_month = params[:card_expiration_month]
    @card_expiration_year =  params[:card_expiration_year]
  end

  def card
    is_authorized?
  end

  private
  
  def is_authorized?
    authorize_response.code =~ SUCCESS_STATUS ? success_response : failed_response
  end
  
  def failed_response
    {
      authorized_status: false,
      authorize_payload: failed_payload
    }
  end
  
  def success_response
    {
      authorized_status: true,
      authorize_payload: success_payload
    }
  end
  
  def failed_payload
    authorize_response_body[:responseStatus]
  end
  
  def success_payload
    authorize_response_body
  end
  
  def authorize_response_body
    JSON.parse(authorize_response.body).with_indifferent_access
  end
  
  def authorize_response
    authorize_card.response
  end
  
  def authorize_card
    HTTParty.post(full_request_url,
                  body: request_body,
                  headers: headers)
  end
  
  def hash_output
    @hash_output ||= OpenSSL::HMAC.hexdigest(digest,shared_secret,hash_input)
  end
  
  def hash_input
    @hash_input ||= timestamp + resource_path + query_string + request_body
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
    @resource_path ||= "payments/v1/authorizations".freeze
  end
  
end