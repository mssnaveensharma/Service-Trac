require 'test_helper'

class Admin::TechSupportsControllerTest < ActionController::TestCase
  setup do
    @admin_tech_support = admin_tech_supports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_tech_supports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_tech_support" do
    assert_difference('Admin::TechSupport.count') do
      post :create, admin_tech_support: { SupportDescription: @admin_tech_support.SupportDescription }
    end

    assert_redirected_to admin_tech_support_path(assigns(:admin_tech_support))
  end

  test "should show admin_tech_support" do
    get :show, id: @admin_tech_support
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_tech_support
    assert_response :success
  end

  test "should update admin_tech_support" do
    patch :update, id: @admin_tech_support, admin_tech_support: { SupportDescription: @admin_tech_support.SupportDescription }
    assert_redirected_to admin_tech_support_path(assigns(:admin_tech_support))
  end

  test "should destroy admin_tech_support" do
    assert_difference('Admin::TechSupport.count', -1) do
      delete :destroy, id: @admin_tech_support
    end

    assert_redirected_to admin_tech_supports_path
  end
end
