class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :title, :default=>"", :null => false
      t.string :description, :default=>"", :null => false
      t.string :image_file, :default=>"", :null => false
      t.float  :gps_x
      t.float :gps_y
      t.timestamps
    end

    @board = Board.new
    @board.title ="渋谷駅掲示板"
    @board.description ="渋谷駅のバーチャル掲示板です。落書きは禁止！"
    @board.gps_x = 139.701118
    @board.gps_y = 35.659354
    @board.image_file = "shibuya_station.jpg"
    @board.save

    @board2 = Board.new
    @board2.title ="鎌倉駅掲示板"
    @board2.description ="鎌倉駅のバーチャル掲示板です。古都鎌倉。観光にいいですよ"
    @board2.gps_x = 139.55143
    @board2.gps_y = 35.321988
    @board2.image_file = "kamakura_station.jpg"
    @board2.save   
  end

  def self.down
    drop_table :boards
  end
end
