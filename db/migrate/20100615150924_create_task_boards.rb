class CreateTaskBoards < ActiveRecord::Migration
  def self.up
    create_table :task_boards do |t|
    
      t.timestamps
    end
  end

  def self.down
    drop_table :task_boards
  end
end
