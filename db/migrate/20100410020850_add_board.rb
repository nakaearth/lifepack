class AddBoard < ActiveRecord::Migration
  def self.up
    @board = Board.new
    @board.title ="青葉台駅掲示板"
    @board.description ="青葉台のバーチャル掲示板です。田園都市線沿いのメジャーな駅です"
    @board.gps_x = 139.517441
    @board.gps_y = 35.543052
    @board.image_file = "aobadai_station.jpg"
    @board.save
  end

  def self.down
  end
end
