class Custom::SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :current_user
end
