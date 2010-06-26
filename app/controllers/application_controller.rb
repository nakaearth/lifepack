# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'rubygems'
require 'log4r'
require 'log4r/configurator'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  mobile_filter :hankaku=>true
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected
  # 未ログイン状態でログインが必要なページに入ろうとすると、元のページに戻される
  # ログイン専用ページがない場合など
  def block_until_authorized
    unless login?
      flash[:notice] = "Please log in"
      session[:jumpto] = request.parameters
      redirect_to("/login")
    end
  end

  protected
  def authorize
    unless session[:user_id]
      flash[:notice] = "Please login"
      # save the URL the user requested so we can hop back to it
      # after login
      session[:jumpto] = request.parameters
      redirect_to(:controller => "/login", :action => "index")
    end
  end
  protected
  def redirect_if_mobile
    if request.mobile?
        redirect_to :controller=>'mo_top_menus'
    end
  end

   private
  def initLogFormat(logFileName)
    logfile="./log/"+logFileName
    progname="log"
    formatter = Log4r::PatternFormatter.new(:pattern => "%d %C[%l]: %M",
    :date_format => "%Y/%m/%d %H:%M:%S")

    @logger = Log4r::Logger.new(progname)
    outputter = Log4r::FileOutputter.new(
              "file",
    :filename => logfile,
    :trunc => false,
    :formatter => formatter)
    @logger.add(outputter)
  end

  def logInfo(message)
    initLogFormat("app_controller_Info.log")
    @logger.info(message)
  end

  def logError(message)
    initLogFormat("app_controller_error.log")
    @logger.error(message)
  end

  def logDebug(message)
    initLogFormat("app_controller_debug.log")
    @logger.debug(message)
  end
end
