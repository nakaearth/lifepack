require File.dirname(__FILE__) + '/../test_helper'

class PlaceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "distant" do
    @places = Place.find(:all,:origin=>[35.326105,139.556411], :within=>100)
    assert_not_nil @places, "NULLだよ。。"
    p @places.size
    for place in @places
      p place.place_name
      p place
    end
  end


end
