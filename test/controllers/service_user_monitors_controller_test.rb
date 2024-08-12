require "test_helper"

class ServiceUserMonitorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_user_monitor = service_user_monitors(:one)
  end

  test "should get index" do
    get service_user_monitors_url, as: :json
    assert_response :success
  end

  test "should create service_user_monitor" do
    assert_difference("ServiceUserMonitor.count") do
      post service_user_monitors_url, params: { service_user_monitor: { schedule: @service_user_monitor.schedule, service_id: @service_user_monitor.service_id, user_id: @service_user_monitor.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show service_user_monitor" do
    get service_user_monitor_url(@service_user_monitor), as: :json
    assert_response :success
  end

  test "should update service_user_monitor" do
    patch service_user_monitor_url(@service_user_monitor), params: { service_user_monitor: { schedule: @service_user_monitor.schedule, service_id: @service_user_monitor.service_id, user_id: @service_user_monitor.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy service_user_monitor" do
    assert_difference("ServiceUserMonitor.count", -1) do
      delete service_user_monitor_url(@service_user_monitor), as: :json
    end

    assert_response :no_content
  end
end
