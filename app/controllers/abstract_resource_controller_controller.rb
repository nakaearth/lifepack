class AbstractResourceControllerController < ApplicationController
  protect_from_forgery  :only => []

  def http_method_dispatch
    send request.env['REQUEST_METHOD'].downcase
  end

  [:get,:post,:put, :delete].each do |http_method|
    define_method(httpd_method){
      render :text => "Forbidden", :status => "405 not allowed"
    }
  end
end
