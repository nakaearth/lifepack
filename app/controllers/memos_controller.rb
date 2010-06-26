class MemosController < ApplicationController
  #before_filter :authorize, :only=>[:new, :edit, :create, :update, :destroy]
  before_filter :redirect_if_mobile
  # GET /memos
  # GET /memos.xml
  def index
    @select_board = Board.find(params[:board_id])
    session[:select_board] = @select_board
    @memos = Memo.find_all_by_board_id(params[:board_id])
    @form_button = 'メモの追加'
    @form_action ='save_memo'
    @memo = Memo.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memos }
    end
  end

   # GET /stars/1
  # GET /stars/1.xml
  def show
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    #コメント一覧取得
    @comments = @memo.comment
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @memo }
    end
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

  #メモ投稿
  def save_memo
    @select_board = session[:select_board]
    @memo = Memo.new(params[:memo])
    @memo.board_id = @select_board.id
    @memo_logical = MemoLogical.new
    @memo = @memo_logical.save_memo(@memo,params[:rePassword])
    #if文で考えよう
    render :update do |page|
      if(@memo == nil)
        page.replace_html 'err_msg_id', '登録エラーです'
        @memos = Memo.all
        @form_button = 'メモの追加'
        @form_action ='save_memo'
        @memo = Memo.new
      else
        page.replace_html 'err_msg_id', ''
        page.call 'Form.reset', 'memo_form'
        page.insert_html :top, 'memoCaption', :partial => 'memo'
        page.draggable "#{@memo.id}"
        page.visual_effect :highlight,"#{@memo.id}",:duration => 3
        #page.visual_effect :slideUp ,"#{@memo.id}"
       end
    end
  end

  # GET /memos/1/edit
  def edit_memo
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    @form_button = 'メモの編集'
    @form_action ='update_memo'
    render :update do |page|
      page.visual_effect :highlight, "#{@memo.id}",  :duration => 0.4
      page[:memo_form].remove
      page.insert_html :top, 'memo_form_block', :partial => 'form'
      page.visual_effect :highlight, "#{@memo.id}",  :duration => 0.6
    end
  end

  # PUT /memos/1
  # PUT /memos/1.xml
  def update_memo
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    @memo.board_id = @select_board.id
    if @memo.update_attributes(params[:memo])
      flash[:notice] = 'Memo was successfully updated.'
      render :update do |page|
        page.replace "#{@memo.id}", :partial => 'memo'
        page.visual_effect :highlight, "#{@memo.id}",  :duration => 0.4
        page[:memo_form].remove
        @form_action = 'save_memo'
        @form_button = 'メモの追加'
        @memo.message=""
        @memo.title = ""
        @memo.author =""
        @memo.password = ""
        page.insert_html :top, 'memo_form_block', :partial => 'form'
      end
    end
  end

  def remove_memo
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    @memo.destroy
    render :update do |page|
      page.visual_effect :slideDown ,"#{@memo.id}"
      page.visual_effect :fade, "#{params[:id]}", :duration => 0.6
    end
  end

  def remove_memo_after_show_detail
    @select_board = session[:select_board]
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to :action => "index"
  end
  
  private
  def redirect_if_mobile
    if request.mobile?
        redirect_to :controller=>'mo_ekimae_board'
    end
  end
end
