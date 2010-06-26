require File.dirname(__FILE__) + '/../test_helper'

class BoardTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "find_ekimae_board" do
    from_date = Date.today -7
    p from_date
    p from_date.strftime("%Y-%m-%d")
  end

  test "find_board_by_postion_model" do
    x_pos = 139
    y_pos = 35
    @boards = Board.find(:all,:conditions=>["gps_x between ? and  ? and gps_y between ? and ?",138 ,140, 34, 36])
    p  @boards[0].title
  end

  test "find_board_by_position_logical" do
    @logical = BoardLogical.new
    @board=@logical.find_board_by_position(139.4,35.5)
    assert_equal "shibuya_station.jpg", @board[0].image_file
  end
end
