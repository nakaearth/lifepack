require 'test_helper'

class MemosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create memo" do
    assert_difference('Memo.count') do
      post :create, :memo => { }
    end

    assert_redirected_to memo_path(assigns(:memo))
  end

  test "should show memo" do
    get :show, :id => memos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => memos(:one).to_param
    assert_response :success
  end

  test "should update memo" do
    put :update, :id => memos(:one).to_param, :memo => { }
    assert_redirected_to memo_path(assigns(:memo))
  end

  test "should destroy memo" do
    assert_difference('Memo.count', -1) do
      delete :destroy, :id => memos(:one).to_param
    end

    assert_redirected_to memos_path
  end
end
