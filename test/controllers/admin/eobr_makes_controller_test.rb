require 'test_helper'

class Admin::EobrMakesControllerTest < ActionController::TestCase
  setup do
    @admin_eobr_make = admin_eobr_makes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_eobr_makes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_eobr_make" do
    assert_difference('Admin::EobrMake.count') do
      post :create, admin_eobr_make: { Name: @admin_eobr_make.Name }
    end

    assert_redirected_to admin_eobr_make_path(assigns(:admin_eobr_make))
  end

  test "should show admin_eobr_make" do
    get :show, id: @admin_eobr_make
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_eobr_make
    assert_response :success
  end

  test "should update admin_eobr_make" do
    patch :update, id: @admin_eobr_make, admin_eobr_make: { Name: @admin_eobr_make.Name }
    assert_redirected_to admin_eobr_make_path(assigns(:admin_eobr_make))
  end

  test "should destroy admin_eobr_make" do
    assert_difference('Admin::EobrMake.count', -1) do
      delete :destroy, id: @admin_eobr_make
    end

    assert_redirected_to admin_eobr_makes_path
  end
end
