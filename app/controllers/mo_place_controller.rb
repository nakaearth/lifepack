class MoPlaceController < MoAbstractController
  def index

  end
def map
    if request.mobile
      @position=session[:now_position]
    #unless @position.nil?
      @position = request.mobile.position
      #画面サイズに合わせて表示
      @display = request.mobile.display ##あってるかな？画面サイズ取得
      @display_height = (@display.physical_height*0.5).to_int
      @display_width= (@display.physical_width*0.7).to_int
      @display_size=@display_height.to_s+"x"+@display_width.to_s
      p @display_size
      #@logical = BoardLogical.new
      #session[:now_position] = @position
      #@boards = @logical.find_board_by_position(@position.lon,@position.lat)
    end
  end
  
  def display_distance
    @place_name = params[:place_name]
    @position=session[:now_position]
    @distance=@position.distance_to(@place_name, :units=>:kms)
  end
end