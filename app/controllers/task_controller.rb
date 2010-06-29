class TaskController < ApplicationController
  before_filter :authorize, :only=>[:index,:list, :show_task_board,:task_list, :edit, :update, :destroy,:add_task,:add_task_list,:show_calendar,:show_past_tasks,:edit_task,:update_task]
  before_filter :redirect_if_mobile

   #インデックス
  def index
    list
    @user_name= session[:user_id].nickname
    if @user_name == nil
      @user_name = session[:user_id].email
    end
    render :action => 'list'
  end

   #タスク看板の表示
  def list
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @user_name= user_id
    @logical = TaskLogical.new
    @toDoTasks = @logical.findTodoAllTaskList(@user_name)
    @doingTasks = @logical.findDoingAllTaskList(@user_name)
    @doneTasks = @logical.findDoneAllTaskList(@user_name)
    @form_action = 'add_task'
    @form_button = 'タスクの追加'
    @task=Task.new
  end

  #タスク看板の表示
  def show_task_board
   list
   render :partial=>"board"
  end

  #タスク一覧
  def task_list
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @user_name= user_id
    @page = Task.paginate(:page => params[:page], :per_page => 10)
    @form_action = 'add_task_list'
    @form_button = 'タスクの追加'
    @task=Task.new
  end

   #編集
  def edit
    @form_action = 'update'
    @form_button = 'タスク編集'
    @task = Task.find(params[:id])
    @task.content = @task.content.gsub("<br/>", "\n")
    render :update do |page|
      page.visual_effect :highlight, "#{@task.id}",  :duration => 0.4
      page[:task_form].remove
      page.insert_html :top, 'task_form_block', :partial => 'form'
      page.visual_effect :highlight, "#{@task.id}",  :duration => 0.6
    end
  end

   #編集実行
  def update
    @logical = TaskLogical.new
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @task = @logical.updateTask(params[:id],params[:task][:content],params[:task][:priority])

    render :update do |page|
      page.replace "#{@task.id}", :partial => 'task'
      page.visual_effect :highlight, "#{@task.id}",  :duration => 0.4
      page[:task_form].remove
      @form_action = 'add_task'
      @form_button = 'タスクの追加'
      @task.content=""
      @task.user_id  = ""
      page.insert_html :top, 'task_form_block', :partial => 'form'
    end
  end

  #タスクの編集
   def edit_task
    @task = Task.find(params[:id])
    @task.content = @task.content.gsub("<br/>", "\n")
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @user_name= user_id
    @form_action = 'update_task'
    @form_button = 'タスク編集'
  end
  def update_task
    @logical = TaskLogical.new
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @task = @logical.updateTask(params[:id],params[:task][:content],params[:task][:priority])
     redirect_to :action => 'task_list'
  end
   #削除
  def destroy
    @logical = TaskLogical.new
    @task = @logical.destroyTask(params[:id])
    render :update do |page|
      page.visual_effect :fade, "#{params[:id]}", :duration => 0.6
    end
  end

   #ドラック＆ドロップでステータス更新
  def change_status
    @logical = TaskLogical.new
    if @task = @logical.changeTaskStatus(params[:id],params[:status])
      render :update do |page|
        page.visual_effect :highlight, "#{params[:id]}", :duration => 0.6
        page.replace("task_info","<font size='3' color='green'>タスクの状況に進捗がありました。お疲れ様です！</font>")
      end
    end
  end

   #タスク追加
  def add_task
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @logical = TaskLogical.new
    @task = @logical.saveTask(params[:task][:content],params[:task][:priority], user_id)
    render :update do |page|
      page.call 'Form.reset', 'task_form'
      page.insert_html :top, 'todoCaption', :partial => 'task'
      page.draggable "#{@task.id}"
      page.visual_effect :highlight,"#{@task.id}",:duration => 1
    end
  end
   #タスクを一覧で追加
  def add_task_list
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @logical = TaskLogical.new
    @task = @logical.saveTask(params[:task][:content],params[:task][:priority], user_id)
    @form_action = 'add_task_list'
    @form_button = 'タスクの追加'
    task_list
    render :action => 'task_list'
  end

   #カレンダー表示
  def show_calendar
    @year = params[:year] ? params[:year].to_i : Time.now.year
    @month =  params[:month] ? params[:month].to_i : Time.now.month
    @next = Date.new(@year, @month, 1) >> 1
    @prev = Date.new(@year, @month, 1) << 1
  end

  def show_past_tasks
    user_id = session[:user_id].email
    if user_id ==nil || (user_id != nil && user_id.isBlank?)
      user_id = session[:user_id].nickname
    end
    @user_name= user_id
    day = params[:year]+'-'+params[:month]+'-'+params[:day]
    @logical = TaskLogical.new
    @tasks = @logical.find_done_tasks_4day(user_id,day)
  end

   #ゴミ箱からの生還
  def recycle
    @logical = TaskLogical.new
    if @task = @logical.changeTaskStatus(params[:id],params[:status])
      render :update do |page|
        page.visual_effect :fade, "#{params[:id]}", :duration => 0.6
      end
    end
  end

   #ゴミ箱確認
  def confirm_recycle
    @logical = TaskLogical.new
    @recycles = @logical.findRecycleTask()
    @form_action = 'confirm_recycle'
  end
end

