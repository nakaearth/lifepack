class AbstractResourceController < ApplicationController
  protect_from_forgery  :only => []

  def http_method_dispatch
    send request.env['REQUEST_METHOD'].downcase
  end

  [:get,:post,:put, :delete].each do |http_method|
    define_method(httpd_method){
      render :text => "Forbidden", :status => "405 not allowed"
    }
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
    initLogFormat("app_webservice_Info.log")
    @logger.info(message)
  end

  def logError(message)
    initLogFormat("app_webservicer_error.log")
    @logger.error(message)
  end

  def logDebug(message)
    initLogFormat("app_webservice_debug.log")
    @logger.debug(message)
  end
end
