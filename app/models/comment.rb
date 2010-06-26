require 'composite_primary_keys'

class Comment < ActiveRecord::Base
  set_primary_keys :memo_id, :comment_id
  belongs_to :comment, :foreign_key => [:memo_id, :comment_id]

  validates_presence_of :author, :message =>"作者名は必ず入れてください"
  validates_presence_of "message", :message =>"作者名は必ず入れてください"
end
