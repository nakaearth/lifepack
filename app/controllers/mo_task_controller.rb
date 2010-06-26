class MoTaskController < ApplicationController
  before_filter :authorize, :only=>[:index,:list,:new]
  before_filter :redirect_if_mobile
  def index
    
  end
  def list

  end
  def new

  end

  def show_calendar

  end

end
