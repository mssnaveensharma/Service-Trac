require 'test_helper'

class ServiceAlertsControllerTest < ActionController::TestCase
  setup do
    @service_alert = service_alerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_alerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_alert" do
    assert_difference('ServiceAlert.count') do
      post :create, service_alert: {  }
    end

    assert_redirected_to service_alert_path(assigns(:service_alert))
  end

  test "should show service_alert" do
    get :show, id: @service_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_alert
    assert_response :success
  end

  test "should update service_alert" do
    patch :update, id: @service_alert, service_alert: {  }
    assert_redirected_to service_alert_path(assigns(:service_alert))
  end

  test "should destroy service_alert" do
    assert_difference('ServiceAlert.count', -1) do
      delete :destroy, id: @service_alert
    end

    assert_redirected_to service_alerts_path
  end
end
