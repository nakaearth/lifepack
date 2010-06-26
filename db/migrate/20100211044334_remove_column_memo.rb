class RemoveColumnMemo < ActiveRecord::Migration
  def self.up
    remove_column :memos, :img_url
  end

  def self.down
    add_column :memos, :img_url,:string,  :null => true
  end
end
