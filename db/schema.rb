# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100605021301) do

  create_table "bad_words", :force => true do |t|
    t.string   "word",       :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", :force => true do |t|
    t.string   "title",       :default => "", :null => false
    t.string   "description", :default => "", :null => false
    t.string   "image_file",  :default => "", :null => false
    t.float    "gps_x"
    t.float    "gps_y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :id => false, :force => true do |t|
    t.integer "memo_id",                   :default => 1,    :null => false
    t.integer "comment_id",                                  :null => false
    t.string  "message",    :limit => 140, :default => "",   :null => false
    t.string  "author",     :limit => 50,  :default => "''", :null => false
  end

  create_table "memos", :force => true do |t|
    t.string   "title",      :default => "", :null => false
    t.string   "message",    :default => "", :null => false
    t.string   "author",     :default => "", :null => false
    t.string   "password",   :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id",   :default => 0,  :null => false
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",                  :null => false
    t.string  "server_url"
    t.string  "salt",       :default => "", :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "place_name",  :default => "", :null => false
    t.string   "description", :default => "", :null => false
    t.string   "place_image", :default => ""
    t.float    "lng"
    t.float    "lat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommend_places", :force => true do |t|
    t.string   "title"
    t.string   "message"
    t.string   "img_url"
    t.string   "author"
    t.string   "password"
    t.integer  "point"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tasks", :force => true do |t|
    t.text     "content",    :limit => 255,                 :null => false
    t.string   "status",                    :default => "", :null => false
    t.string   "user_id",    :limit => 60,  :default => "", :null => false
    t.integer  "priority",                  :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["status", "updated_at"], :name => "index_tasks_on_status_and_updated_at"
  add_index "tasks", ["status"], :name => "index_tasks_on_status"

end
