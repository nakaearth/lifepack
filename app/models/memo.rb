class Memo < ActiveRecord::Base
  belongs_to :board
  has_many :comment
  validates_presence_of :author, :message =>"名前は必ず入れてください"
  validates_presence_of "message", :message =>"メッセージは必ず入れてください"

  def display_list
    from_date = Date.today-7
    @memo_list = Memo.find(:all,:conditions => ['created_at > ?',from_date.strftime("%Y-%m-%d")])
  end

end
