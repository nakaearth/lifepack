#require 'date'

class Board < ActiveRecord::Base
  has_many :memos
  def display_list
    from_date = Date.today-7
    @board_list = Board.find(:all,:conditions => ['created_at > ?',from_date.strftime("%Y-%m-%d")])
  end

end
