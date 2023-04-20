require "test_helper"

class HealthCheckControllerTest < ActionDispatch::IntegrationTest
  test "should get ping" do
    get health_check_ping_url
    assert_response :success
  end
end
