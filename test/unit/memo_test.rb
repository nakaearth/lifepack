require File.dirname(__FILE__) + '/../test_helper'

class MemoTest < ActiveSupport::TestCase
   fixtures :memos,:comments
  # Replace this with your real tests.
  test "composite_primary_keys Find" do
    #assert true
    @memo = Memo.find(1)
    assert @memo.comment[0].message, "ほげほげほげ"
  end

   test "composite_primary_keys Find2" do
    #assert true
    @comment = Comment.find(:all, :conditions=>["memo_id=? and comment_id=?",1,1])
    assert @comment[0].message, "ほげほげほげ"
  end

end
