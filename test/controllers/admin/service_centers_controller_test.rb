require 'test_helper'

class Admin::ServiceCentersControllerTest < ActionController::TestCase
  setup do
    @admin_service_center = admin_service_centers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_service_centers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_service_center" do
    assert_difference('Admin::ServiceCenter.count') do
      post :create, admin_service_center: { City: @admin_service_center.City, ContactPerson: @admin_service_center.ContactPerson, Email: @admin_service_center.Email, Fax: @admin_service_center.Fax, Name: @admin_service_center.Name, Pin: @admin_service_center.Pin, State: @admin_service_center.State, Tel: @admin_service_center.Tel, Url: @admin_service_center.Url }
    end

    assert_redirected_to admin_service_center_path(assigns(:admin_service_center))
  end

  test "should show admin_service_center" do
    get :show, id: @admin_service_center
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_service_center
    assert_response :success
  end

  test "should update admin_service_center" do
    patch :update, id: @admin_service_center, admin_service_center: { City: @admin_service_center.City, ContactPerson: @admin_service_center.ContactPerson, Email: @admin_service_center.Email, Fax: @admin_service_center.Fax, Name: @admin_service_center.Name, Pin: @admin_service_center.Pin, State: @admin_service_center.State, Tel: @admin_service_center.Tel, Url: @admin_service_center.Url }
    assert_redirected_to admin_service_center_path(assigns(:admin_service_center))
  end

  test "should destroy admin_service_center" do
    assert_difference('Admin::ServiceCenter.count', -1) do
      delete :destroy, id: @admin_service_center
    end

    assert_redirected_to admin_service_centers_path
  end
end
