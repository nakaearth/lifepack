class PlacesController < ApplicationController
  before_filter :redirect_if_mobile
  
  def index
    @places = Place.all
    #掲示板の位置にマーカを
    @map = GoogleMap.new(:dom_id=>'map')
    for place in @places
      @map.markers << GoogleMapMarker.new(:map => @map,
        :html =>place.place_name+":"+place.description,:lat => place.lat.to_f,  
                                   :lng =>place.lng.to_f  
                                  )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  do
        render :xml => @places
      end
    end
  end

  def find_places_by_address
    address=params[:address]
    distant=params[:distant]
    @places = Place.find(:all,:origin=>address, :within=>distant.to_i)
    @map = GoogleMap.new(:dom_id=>'map')
    for place in @places
      @map.markers << GoogleMapMarker.new(:map => @map,
        :html =>place.place_name+":"+place.description,:lat => place.lng.to_f,
                                   :lng => place.lat.to_f   
                                  )
    end
    render :update do |page|
        page['places_map'].remove
        page.insert_html :top, 'map_top', :partial => 'places_map'
    end
  end
 
end
