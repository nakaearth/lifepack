class CreateMemos < ActiveRecord::Migration
  def self.up
    create_table :memos do |t|
      t.string :title ,:null => false, :limit => 50
      t.string :message ,:null => false,:limit => 300
      t.string :img_url
      t.string :author ,:null => false,:limit =>20
      t.string :password ,:null => false,:limit => 16

      t.timestamps
    end
  end

  def self.down
    drop_table :memos
  end
end
