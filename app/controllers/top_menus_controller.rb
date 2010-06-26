class TopMenusController < ApplicationController
  def index
   if session[:user_id] !=nil
     session[:user_id] = nil
   end
  end
end
