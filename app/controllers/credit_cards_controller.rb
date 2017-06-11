class CreditCardsController < ApplicationController
  
  def authorize_card
    respond_to do |format|
      format.json do
        render json: Visa::CyberSource::Authorize.card(credit_card_params)
      end
    end
  end
  
  def create_payment
    auth_response = Visa::CyberSource::Authorize.card(credit_card_params)[:payment_status]
    respond_to do |format|
      format.json do 
        if auth_response
          render json: Visa::CyberSource::Payment.create(credit_card_params)
        else
          render json: auth_response[:authorize_payload]
        end  
      end  
    end
  end
  
  def create_premium_payment
    if !current_user.premium
      credit_card_params[:amount] = 49.99
      auth_response = Visa::CyberSource::Authorize.card(credit_card_params)
      if auth_response[:authorized_status]
        response = Visa::CyberSource::Payment.create(credit_card_params)
        current_user.premium = response[:payment_status]
      else
        response = auth_response
      end
    else
      response = {status: 400, reason: "missing_field", message: "User is already Premium"}
    end
    respond_to do |format|
      format.json do 
          render json: response
      end  
    end
  end
  
  private
  
  def credit_card_params
    params.require(:amount, :card_number, :card_expiration_month, :card_expiration_year)
  end
  
end
