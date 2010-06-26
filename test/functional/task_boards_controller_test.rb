require 'test_helper'

class TaskBoardsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_board" do
    assert_difference('TaskBoard.count') do
      post :create, :task_board => { }
    end

    assert_redirected_to task_board_path(assigns(:task_board))
  end

  test "should show task_board" do
    get :show, :id => task_boards(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => task_boards(:one).to_param
    assert_response :success
  end

  test "should update task_board" do
    put :update, :id => task_boards(:one).to_param, :task_board => { }
    assert_redirected_to task_board_path(assigns(:task_board))
  end

  test "should destroy task_board" do
    assert_difference('TaskBoard.count', -1) do
      delete :destroy, :id => task_boards(:one).to_param
    end

    assert_redirected_to task_boards_path
  end
end
