class SessionsController < ApplicationController
	before_filter :save_login_state, :only => [:login, :login_attempt]

	def login
		@posts = Post.all
		flash[:notice] = "Welcome to Login Page !"
		flash[:color] = "valid"
	end

	def login_attempt
		@posts = Post.all
		authorized_user = User.authenticate(params[:username_or_email], params[:password])
		if authorized_user
			session[:user_id] = authorized_user.id
			@loggedin_user = User.find(session[:user_id])
			redirect_to(:controller => 'posts', :action => 'index')
		else
			flash[:notice] = "Invalid Username / Password"
			flash[:color]= "invalid"
			render 'login'	
		end
	end

	def logout
		@posts = Post.all
		flash[:notice] = "You have logged out successfully"
		flash[:color] = "valid"
		session[:user_id] = nil
	end
end