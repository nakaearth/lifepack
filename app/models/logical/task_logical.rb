require 'date'

class TaskLogical < AbstractLogical
  @@TODO = "todo"
  @@DOING = "doing"
  @@DONE = "done"
  
  def findTodoAllTaskList(user_id)
    begin   
      @todoTasks = Task.find(:all, :conditions=>["status=? and user_id =?",@@TODO,user_id],:order=> "priority desc,updated_at desc" )
      logInfo(@todoTasks)
      return @todoTasks
    rescue
      logError("findTodoAllTaskList:error.")
      logError(user_id)
      return Array.new
    end
  end
  
  def findDoingAllTaskList(user_id)
    begin
      @doingTasks = Task.find(:all, :conditions=>["status=? and user_id=?",@@DOING,user_id],:order=> "updated_at desc" )
      logInfo(@doingTasks)
      return @doingTasks
    rescue
      logError("findDoingAllTaskList:error.:User_id:")
      return Array.new
    end
  end
  
  def findDoneAllTaskList(user_id)
    begin
      @doneTasks = Task.find(:all, :conditions=>["status=? and user_id=? and updated_at < ? and updated_at >= ?",@@DONE,user_id,Date.today+1,Date.today],:order=> "updated_at desc" )
      logInfo(@doneTasks)
      return @doneTasks
    rescue
      logError("findDoneAllTaskList:error.:User_id:")
      return Array.new
    end
  end

  def find_done_tasks_4day(user_id,day)
    next_day = day+1
    begin
      @doneTasks = Task.find(:all, :conditions=>["status=? and user_id=? and updated_at < ? and updated_at >= ?",@@DONE,user_id,next_day.to_s,day],:order=> "updated_at desc" )
      logInfo(@doneTasks)
      return @doneTasks
    rescue => e
      logError("Exception:"+e.to_s)
      logError("findDoneTaskListByDay.:User_id:")
      logError(day)
      logError(next_day)
      return Array.new
    end
  end

  
  def saveTask(content,priority,  user_id)
    begin
      Task.transaction do
        @task = Task.new
        @task.status = 'todo'
        @task.priority = priority
        @task.content = content.gsub("\n", "<br/>")
        @task.user_id = user_id
        @task.save
        logDebug(@task.id)
        return @task
      end
    rescue 
      logError("saveTask:error.:User_id:")
    end
  end
  
  def updateTask(task_id,content,priority)
    begin
      Task.transaction do
        @task = Task.find(task_id)
        #@task.priority = priority
        #@task.content = content.gsub("\n","<br/>")
        #@task.save
        @task.update_attributes({:priority => priority, :content=>content.gsub("\n","<br/>")})
        return @task
      end
    rescue 
      logError("updateTask:error.:User_id:")
    end
  end
  
  def destroyTask(task_id)
    return  Task.find(task_id).destroy
  end
  
  def changeTaskStatus(task_id,status)
    @task = Task.find(task_id)
    return @task.update_attributes(:status => status)
  end
  
  def taskRecycle(task_id,status)
    @task = Task.find(task_id)
    return @task.update_attributes(:status => status)
  end
  
  def findRecycleTask()
    return @recycles = Task.find(:all, :conditions=>["status=?","recycle"],:order=> "priority desc")
  end
  
  private
  def initPinejuiceLogFormat(logFileName)
    logfile="./log/"+logFileName
    #logfile="./log/pinejuice.log"
    progname="pinejuiceLog"
    formatter = Log4r::PatternFormatter.new(:pattern => "%d %C[%l]: %M",
    :date_format => "%Y/%m/%d %H:%M:%S")
    
    @pinejuiceLogger = Log4r::Logger.new(progname)
    outputter = Log4r::FileOutputter.new(
              "file",
    :filename => logfile,
    :trunc => false,
    :formatter => formatter)
    @pinejuiceLogger.add(outputter)
  end
  
  def logInfo(message)
    initPinejuiceLogFormat("managerInfo.log")
    @pinejuiceLogger.info(message)
  end
  
  def logError(message)
    initPinejuiceLogFormat("managerError.log")
    @pinejuiceLogger.error(message)
  end
  
  def logDebug(message)
    initPinejuiceLogFormat("managerDebug.log")
    @pinejuiceLogger.debug(message)
  end

  def date_format(date)
    if date != nil
      Date.today.strftime "%Y-%m-%d"
    els
      date.strftime( "%Y-%m-%d")
    end
  end
  
end