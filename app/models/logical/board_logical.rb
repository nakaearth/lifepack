# To change this template, choose Tools | Templates
# and open the template in the editor.

class BoardLogical < AbstractLogical
  def initialize
    
  end
  def find_board_by_position(x_pos, y_pos)
    begin
      Board.transaction do
      if x_pos ==nil || y_pos == nil
        return Board.find(:all)
      end
      @boards = Board.find(:all,:conditions => ["gps_x between ? and  ? and gps_y between ? and ?",x_pos - 0.03 ,x_pos +0.03, y_pos-0.03, y_pos+0.03])
      return @boards
    end
    rescue Exception => e #大きな範囲で例外がある場合
      logError("地図")
      logError(x_pos.to_s+":"+ y_pos.to_s)
      #例外処理
      return List.new
    end
  end

end
