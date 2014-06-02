require 'test_helper'

class ElectronicsControllerTest < ActionController::TestCase
  setup do
    @electronic = electronics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:electronics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create electronic" do
    assert_difference('Electronic.count') do
      post :create, electronic: {  }
    end

    assert_redirected_to electronic_path(assigns(:electronic))
  end

  test "should show electronic" do
    get :show, id: @electronic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @electronic
    assert_response :success
  end

  test "should update electronic" do
    patch :update, id: @electronic, electronic: {  }
    assert_redirected_to electronic_path(assigns(:electronic))
  end

  test "should destroy electronic" do
    assert_difference('Electronic.count', -1) do
      delete :destroy, id: @electronic
    end

    assert_redirected_to electronics_path
  end
end
