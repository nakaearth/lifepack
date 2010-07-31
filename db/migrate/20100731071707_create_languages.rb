class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :word,:limit => 60, :default => "", :null => false
      t.string :parse , :null => false,:limit => 20
      t.string :category , :null => false,:limit => 30
      t.integer :count, :default=>0
      t.timestamps
    end
    add_index :languages, [:category,:word]
  end

  def self.down
    drop_table :languages
  end
end
