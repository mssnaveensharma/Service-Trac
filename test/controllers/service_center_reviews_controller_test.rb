require 'test_helper'

class ServiceCenterReviewsControllerTest < ActionController::TestCase
  setup do
    @service_center_review = service_center_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_center_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_center_review" do
    assert_difference('ServiceCenterReview.count') do
      post :create, service_center_review: {  }
    end

    assert_redirected_to service_center_review_path(assigns(:service_center_review))
  end

  test "should show service_center_review" do
    get :show, id: @service_center_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_center_review
    assert_response :success
  end

  test "should update service_center_review" do
    patch :update, id: @service_center_review, service_center_review: {  }
    assert_redirected_to service_center_review_path(assigns(:service_center_review))
  end

  test "should destroy service_center_review" do
    assert_difference('ServiceCenterReview.count', -1) do
      delete :destroy, id: @service_center_review
    end

    assert_redirected_to service_center_reviews_path
  end
end
