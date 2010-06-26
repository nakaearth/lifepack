class MoEkimaeBoardController < MoAbstractController
  trans_sid
  def index
    case request.mobile
    when Jpmobile::Mobile::Docomo
      p 'for DoCoMo'
    when Jpmobile::Mobile::Au
      p 'for au'
    when Jpmobile::Mobile::Softbank
      p 'for SoftBank'
    when Jpmobile::Mobile::Willcom
      p 'for Willcom'
    when Jpmobile::Mobile::Emobile
      p 'for EMOBILE'
    when Jpmobile::Mobile::Iphone
      p 'for Iphone'
    else
      # for PC
    end
  end
  #latitude 緯度  longuitude 経度
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
      @logical = BoardLogical.new
      session[:now_position] = @position
      @boards = @logical.find_board_by_position(@position.lon,@position.lat)

      #@boards2=@postion.find(id, client)
    end 
  end
end
