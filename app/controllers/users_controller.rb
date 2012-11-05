class UsersController < ApplicationController
 
  before_filter :save_login_state

  def new
    flash[:notice] = "Welcome to Sign-Up Page !"
    flash[:color] = "valid"
    @user = User.new    
  end

  def create
    @user=User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect_to(:controller => 'posts', :action => 'index')
        UserMailer.signup_confirmation(@user).deliver
      else
        flash[:notice] = "Form is invalid"
        flash[:color] = "invalid"
        render "new"
      end
  end
end