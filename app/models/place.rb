class Place < ActiveRecord::Base
  #include ::GeoKit::Mappable
  acts_as_mappable
end
