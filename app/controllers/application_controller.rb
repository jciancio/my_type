class ApplicationController < ActionController::API
  before_action :current_user
  before_action :authenticate_user

  def current_user
    begin
      @current_user ||= User.find_by_email(params[:email]) if params[:email]
    rescue Exception => e
      {
        status: 500,
        error: {
          message: "#{'*' * 100} #{e.message} #{'*' * 100}"
        }
      }
    end
  end

  def authenticate_user
    render json: {staus: 401, message: 'Unauthenticated!'} unless current_user.try(:authenticate, params[:password])
  end
end
