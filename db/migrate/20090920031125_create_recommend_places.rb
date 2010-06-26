class CreateRecommendPlaces < ActiveRecord::Migration
  def self.up
    create_table :recommend_places do |t|
      t.string :title
      t.string :message
      t.string :img_url
      t.string :author
      t.string :password
      t.integer :point
      t.timestamps
    end
  end

  def self.down
    drop_table :recommend_places
  end
end
