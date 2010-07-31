class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.text :word,:limit => 60, :default => "", :null => false
      t.string :parse , :null => false
      t.integer :count, :default=>0
      t.timestamps
    end
  end

  def self.down
    drop_table :languages
  end
end
