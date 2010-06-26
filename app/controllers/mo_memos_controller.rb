class MoMemosController < MoAbstractController
  #mobile_filter :hankaku=>true
  def index
    @select_board = Board.find(params[:board_id])
    session[:select_board] = @select_board
    @memos = Memo.find_all_by_board_id(params[:board_id])
  end

  def write_form
     @select_board= session[:select_board]
  end

  def save_memo
    @memo = Memo.new(request[:memo])
    @select_board = session[:select_board]
    @memo.board_id = @select_board.id
    if (@memo.save)
      redirect_to :action=>'index',:board_id=>@select_board.id
    else
      redirect_to :action=>'write_form'
    end
  end

  def show_memo
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    #コメント一覧取得
    @comments = @memo.comment
  end

  #コメント投稿
  def new_comment
   @select_board = session[:select_board]
   @memo = Memo.find(params[:id])
  end

  def save_comment
    @select_board = session[:select_board]
    @comment = Comment.new(params[:comment])
    @comment.memo_id = params[:id]
    if @comment.save
      redirect_to :action =>"show", :id=>params[:id]
    else
      redirect_to :action => "new_comment",:id=>params[:id]
    end
  end

 def remove_memo_after_show_detail
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to :action => "index"
  end

end
