class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def current_user
    begin
      @current_user ||= User.find(params[:user_id])
    rescue Exception => e
      {
        status: 500,
        error: {
          message: "#{'*' * 100} #{e.message} #{'*' * 100}"
        }
      }
    end
  end
end
