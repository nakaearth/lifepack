class CreateBadWords < ActiveRecord::Migration
  def self.up
    create_table :bad_words do |t|
      t.string :word, :default=>"", :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :bad_words
  end
end
