class EkimaeBoardController < ApplicationController
   before_filter :redirect_if_mobile
   
  def index
    @boards = Board.all
    #掲示板の位置にマーカを
    @map = GoogleMap.new(:dom_id=>'map')
    for board in @boards
      @map.markers << GoogleMapMarker.new(:map => @map,
        :html =>board.description,:lat => board.gps_y.to_f,   # 緯度
                                   :lng => board.gps_x.to_f   # 経度
                                  )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  do
        render :xml => @boards
      end
    end
  end

  #private
  #def redirect_if_mobile
  #  if request.mobile?
  #      redirect_to :controller=>'mo_ekimae_board'
  #  end
  #end
 
end
