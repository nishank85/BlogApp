class ApplicationController < ActionController::Base
	protect_from_forgery
  helper_method :user_def

  def user_def
    @loggedin_user = nil
    if session["user_id"] 
      @loggedin_user = User.find(session[:user_id]) 
    end
    @loggedin_user
  end 	

  protected
  def authenticate_user
   unless session[:user_id]
     redirect_to(:controller => 'sessions', :action => 'login')
     @loggedin_user = User.find(session[:user_id])
     return false
   else
        # set current_user by the current user object
        @current_user = User.find(session[:user_id]) 
        return true
      end
    end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'posts', :action => 'index')
      return false
    else
      return true
    end
  end
end