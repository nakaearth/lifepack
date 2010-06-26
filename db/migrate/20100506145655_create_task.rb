class CreateTask < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.text :content,:limit => 80, :default => "", :null => false
      t.string :status , :null => false
      t.integer :user_id
      t.integer :priority, :default=>1
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
