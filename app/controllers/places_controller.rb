class PlacesController < ApplicationController
  before_filter :redirect_if_mobile
  
  def index
    @places = Place.all
    #掲示板の位置にマーカを
    @map = GoogleMap.new(:dom_id=>'map')
    for place in @places
      @map.markers << GoogleMapMarker.new(:map => @map,
        :html =>place.description,:lat => place.lng.to_f,   # 緯度 35.326105
                                   :lng => place.lat.to_f   # 経度 139.556424
                                  )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  do
        render :xml => @places
      end
    end
  end

  def find_place_by_address
    address=params[:address]
    distant=params[:distant]
    @places = Place.find(:all,:origin=>address, :within=>distant.to_i)
    @map = GoogleMap.new(:dom_id=>'map')
    for place in @places
      @map.markers << GoogleMapMarker.new(:map => @map,
        :html =>place.description,:lat => place.lng.to_f,   
                                   :lng => place.lat.to_f   
                                  )
    end

  end

  def find_place_by_distant(distant,place_x, place_y)
#    @places = Place.find(:all,:origin=>[place_x,place_y], :width=>distant)
    for place in @places
      @map.markers << GoogleMapMarker.new(:map => @map,
        :html =>place.description,:lat => place.lng.to_f,   
                                   :lng => place.lat.to_f   
                                  )
    end
    render :update do |page|
      page['places_map'].remove
      page.insert_html :top, 'task_form_block', :partial => 'places_map'
    end
   # render :partial=>"places_map"
  end
end
