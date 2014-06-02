require 'test_helper'

class Admin::EobrModelsControllerTest < ActionController::TestCase
  setup do
    @admin_eobr_model = admin_eobr_models(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_eobr_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_eobr_model" do
    assert_difference('Admin::EobrModel.count') do
      post :create, admin_eobr_model: { EobrMake_id: @admin_eobr_model.EobrMake_id, Name: @admin_eobr_model.Name }
    end

    assert_redirected_to admin_eobr_model_path(assigns(:admin_eobr_model))
  end

  test "should show admin_eobr_model" do
    get :show, id: @admin_eobr_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_eobr_model
    assert_response :success
  end

  test "should update admin_eobr_model" do
    patch :update, id: @admin_eobr_model, admin_eobr_model: { EobrMake_id: @admin_eobr_model.EobrMake_id, Name: @admin_eobr_model.Name }
    assert_redirected_to admin_eobr_model_path(assigns(:admin_eobr_model))
  end

  test "should destroy admin_eobr_model" do
    assert_difference('Admin::EobrModel.count', -1) do
      delete :destroy, id: @admin_eobr_model
    end

    assert_redirected_to admin_eobr_models_path
  end
end
