# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rubygems'
require 'log4r'
require 'log4r/configurator'

class AbstractLogical
  def initialize
    
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
    initLogFormat("appInfo.log")
    @logger.info(message)
  end

  def logError(message)
    initLogFormat("appError.log")
    @logger.error(message)
  end

  def logDebug(message)
    initLogFormat("appDebug.log")
    @logger.debug(message)
  end

  def checkInputword(input)
    #禁止文字列チェック
    @words = BadWord.all
    flag = true
    for @word in @words
      @result = input.gsub(@ward)
      if (@result != null && @result.length > 0)
        break
     end
    end
    reurn flag
  end

end
