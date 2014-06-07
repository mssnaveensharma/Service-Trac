require 'test_helper'

class AlertDetailsControllerTest < ActionController::TestCase
  setup do
    @alert_detail = alert_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alert_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alert_detail" do
    assert_difference('AlertDetail.count') do
      post :create, alert_detail: {  }
    end

    assert_redirected_to alert_detail_path(assigns(:alert_detail))
  end

  test "should show alert_detail" do
    get :show, id: @alert_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alert_detail
    assert_response :success
  end

  test "should update alert_detail" do
    patch :update, id: @alert_detail, alert_detail: {  }
    assert_redirected_to alert_detail_path(assigns(:alert_detail))
  end

  test "should destroy alert_detail" do
    assert_difference('AlertDetail.count', -1) do
      delete :destroy, id: @alert_detail
    end

    assert_redirected_to alert_details_path
  end
end
