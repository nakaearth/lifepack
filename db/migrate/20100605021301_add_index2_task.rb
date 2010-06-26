class AddIndex2Task < ActiveRecord::Migration
  def self.up
    add_index :tasks, :status
  end

  def self.down
  end
end
