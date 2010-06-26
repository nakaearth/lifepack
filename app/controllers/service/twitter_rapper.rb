# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'twitter'
require 'pp'

class TwitterRapper
  def initialize
    
  end

  def get_friends_line(user_id, password)
      @client = Twitter::Client.new(:login=>user_id, :password=>password)
      @timeline = @client.timeline_for(:friend, :count=>10)
  end

  def get_friends_messages(user_id, password)
     @clients = Twitter::Client.new(:login=>user_id, :password=>password)
     @friends = @clients.timeline_for(:friend, :count=>10)
    # @clients.timeline_for(:friend, :count=>10).each() { |client|
    #   pp client.user.screen_name+":"+client.text
    # }
  end

  def dump
    @timeline.each do |status|
      pp status.to_hash
    end
  end
  
end
