class AddBoardIdcolumnMemos < ActiveRecord::Migration
  def self.up
    add_column :memos, :board_id,:integer, :default=>0, :null => false
  end

  def self.down
    remove_column :memos, :board_id
  end
end
