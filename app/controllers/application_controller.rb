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
    render_response(error: {message: 'Unauthenticated!'}, status: 401) unless current_user.try(:authenticate, params[:password])
  end

  def render_response(opts={})
    opts = HashWithIndifferentAccess.new(opts)
    return render_error_from(opts[:error], opts[:error].message, opts[:status]) if !!opts[:error]
    render_json(opts[:data], opts[:message], opts[:status])
  end

  def render_error_from(error, message='', status=500)
    render json: {
      status: status,
      error: {
        message: "#{'*' * 100} #{message} #{'*' * 100}",
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

class Hash
  def message
    self[:message]
  end

  def backtrace
    self.message
  end
end
