require 'test_helper'

class RecommendPlacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recommend_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recommend_place" do
    assert_difference('RecommendPlace.count') do
      post :create, :recommend_place => { }
    end

    assert_redirected_to recommend_place_path(assigns(:recommend_place))
  end

  test "should show recommend_place" do
    get :show, :id => recommend_places(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => recommend_places(:one).to_param
    assert_response :success
  end

  test "should update recommend_place" do
    put :update, :id => recommend_places(:one).to_param, :recommend_place => { }
    assert_redirected_to recommend_place_path(assigns(:recommend_place))
  end

  test "should destroy recommend_place" do
    assert_difference('RecommendPlace.count', -1) do
      delete :destroy, :id => recommend_places(:one).to_param
    end

    assert_redirected_to recommend_places_path
  end
end
