class User < ActiveRecord::Base
  has_many :tasks, :order =>"priority"
  validates_presence_of :login, :message => "No Input data(login)."
  validates_format_of :email, :with=> /([a-zA-Z0-9]+)@([a-zA-Z0-9]+)/  , :message => "E-Mailデータを入力してください。."
  
  
end
