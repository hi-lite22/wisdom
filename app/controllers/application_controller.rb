class ApplicationController < ActionController::Base
  helper_method :user_info
 
  def user_info(user_id)
    User.find(user_id)
  end
  
end