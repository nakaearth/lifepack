class AddColumnMemo < ActiveRecord::Migration
  def self.up
    add_column :memos, :tag_name,:string, :default=>"", :null => false
  end

  def self.down
    #remove_column :memos, :tag_name
  end
end
