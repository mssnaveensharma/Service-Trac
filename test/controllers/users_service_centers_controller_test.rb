require 'test_helper'

class UsersServiceCentersControllerTest < ActionController::TestCase
  setup do
    @users_service_center = users_service_centers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_service_centers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_service_center" do
    assert_difference('UsersServiceCenter.count') do
      post :create, users_service_center: {  }
    end

    assert_redirected_to users_service_center_path(assigns(:users_service_center))
  end

  test "should show users_service_center" do
    get :show, id: @users_service_center
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @users_service_center
    assert_response :success
  end

  test "should update users_service_center" do
    patch :update, id: @users_service_center, users_service_center: {  }
    assert_redirected_to users_service_center_path(assigns(:users_service_center))
  end

  test "should destroy users_service_center" do
    assert_difference('UsersServiceCenter.count', -1) do
      delete :destroy, id: @users_service_center
    end

    assert_redirected_to users_service_centers_path
  end
end
