class ChangeColumnTask < ActiveRecord::Migration
  def self.up
    change_column :tasks, :user_id, :string,:null => false,:limit => 60
  end

  def self.down
  end
end
