require 'test_helper'

class VehicleLocationsControllerTest < ActionController::TestCase
  setup do
    @vehicle_location = vehicle_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicle_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle_location" do
    assert_difference('VehicleLocation.count') do
      post :create, vehicle_location: {  }
    end

    assert_redirected_to vehicle_location_path(assigns(:vehicle_location))
  end

  test "should show vehicle_location" do
    get :show, id: @vehicle_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle_location
    assert_response :success
  end

  test "should update vehicle_location" do
    patch :update, id: @vehicle_location, vehicle_location: {  }
    assert_redirected_to vehicle_location_path(assigns(:vehicle_location))
  end

  test "should destroy vehicle_location" do
    assert_difference('VehicleLocation.count', -1) do
      delete :destroy, id: @vehicle_location
    end

    assert_redirected_to vehicle_locations_path
  end
end
