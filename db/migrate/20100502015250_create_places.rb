class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :place_name, :default=>"", :null => false
      t.string :description, :default=>"", :null => false
      t.string :place_image,:size=>255, :default=>"", :null => true
      t.float  :lng
      t.float :lat
      t.timestamps
    end
    @place = Place.new
    @place.place_name ="鶴ヶ丘八幡宮"
    @place.description ="古都鎌倉の代表的な建物です。"
    @place.lng = 35.326105
    @place.lat = 139.556424
    @place.save

  end

  def self.down
    drop_table :places
  end
end
