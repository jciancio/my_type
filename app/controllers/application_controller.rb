class ApplicationController < ActionController::API
  before_action :current_user
  before_action :authenticate_user

  def current_user
    begin
      @current_user ||= User.find_by_email(params[:email]) if params[:email]
    rescue Exception => e
      render_response(error: e)
    end
  end

  def authenticate_user
    render_response(status: 401, message: 'Unauthenticated!') unless current_user.try(:authenticate, params[:password])
  end

  def render_response(opts={})
    opts = HashWithIndifferentAccess.new(opts)
    render_error_from(opts[:error], opts[:error].message) if opts[:error] && return
    render_json(opts[:data], opts[:message])
  end

  def render_error_from(error, message='', status=500)
    e_message = message.empty? ? message : error.message

    render json: {
      status: status,
      error: {
        message: "#{'*' * 100} #{e_message} #{'*' * 100}",
        backtrace: "#{error.backtrace}"
      }
    }
  end

  def render_json(data, message='', status=200)
    render json: {
      status: status,
      message: message,
      data: data
    }
  end
end
