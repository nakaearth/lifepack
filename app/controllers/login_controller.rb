require 'ostruct'

class LoginController < ApplicationController
  def index
    redirect_to :controller => "task" if session[:user_id]
  end

  def login
    if using_open_id?
      authenticate
    else
      flash[:error] = "You must provide an OpenID URL"
      redirect_to :action => "index"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => "index"
  end

  protected
    def authenticate(identity_url = "")
      authenticate_with_open_id(
      params[:openid_url], :required => [:nickname, :email,:fullname]) do
        |result, identity_url, registration|

        if result.successful?
          @user = OpenStruct.new
          @user.identity_url = identity_url
          @user.nickname = registration["nickname"]
          @user.email = registration["email"]
          @user.fullname = registration["fullname"]
          session[:user_id] = @user

          jumpto = session[:jumpto] || { :controller => "task" }
          session[:jumpto] = nil
          redirect_to(jumpto)
        else
          flash[:error] = result.message
          redirect_to :action => "index"
        end
      end
    end

    def root_url
      openid_url
    end
end
