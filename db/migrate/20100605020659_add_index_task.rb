class AddIndexTask < ActiveRecord::Migration
  def self.up
    add_index :tasks, [:status,:updated_at]
  end

  def self.down
  end
end
