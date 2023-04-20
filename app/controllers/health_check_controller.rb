class HealthCheckController < ActionController::API

  def ping
    render plain: "OK"
  end
end
