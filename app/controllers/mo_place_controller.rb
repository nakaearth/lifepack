class MoPlaceController < MoAbstractController
  def index

  end
def map
    if request.mobile
      @position=session[:now_position]
      @position = request.mobile.position unless @position.nil?
      if @position.nil?
        redirect_to :action=>'index'
      end
      #画面サイズに合わせて表示
      @display = request.mobile.display ##あってるかな？画面サイズ取得
      @display_height = (@display.physical_height*0.5).to_int
      @display_width= (@display.physical_width*0.7).to_int
      @display_size=@display_height.to_s+"x"+@display_width.to_s
      session[:now_position] = @position
    end
  end
  
  def display_distance
    @place_name = params[:place_name]
    @position=session[:now_position]
    @distance=@position.distance_to(@place_name, :units=>:kms)
  end

  def new

  end
  def recommend_place
    @position=session[:now_position]
    @place = Place.new(params[:place])
    @place.lat = @position.lat
    @place.lng = @position.lon
   # @place.place_name = params[:place_name]
   # @place.description = params[:description]
    if @place.save
      flash[:flash]='登録完了'
      redirect_to :action=>'map'
    else
      flash[:error]='登録エラー'
      redirect_to :action=>'new'
    end
  end
  
end
