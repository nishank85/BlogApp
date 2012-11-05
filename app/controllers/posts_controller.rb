class PostsController < ApplicationController
  before_filter :authenticate_user, :except => [:index, :show ]
  
  def like
    @post = Post.includes(:comments).find(params[:id])
    @loggedin_user = User.find(session[:user_id])
    if @loggedin_user.flagged?(@post, :like)
      @loggedin_user.unflag!(@post,:like)
      msg = "You now dont like this Post"
    else
      @loggedin_user.flag!(@post,:like)
      msg = "You now like this Post"
      @count = nil
      @count = @post.flaggings.count
      Rails.logger.debug("***************************************")
      puts @count # stores number of likes of a particular post
      Rails.logger.debug("***************************************")
    end
    redirect_to post_url, :notice => msg
  end

  def index
    @posts = Post.includes(:comments).search(params[:search]).paginate(per_page:2, page: params[:page]).order("created_at DESC")
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments
    @totalcomments = @post.comments.count.to_i
    @loggedin_user = user_def
    @count = @post.flaggings.count
  end

  def new
    @post = Post.new
  end

  def edit
    @post = user_def.posts.find(params[:id])
    unless @post.user == user_def
      flash[:notice] = 'You are not authorized to Edit this Post.'
      flash[:color] = 'invalid'
      redirect_to posts_path
    end
  end

  def create
    @post = user_def.posts.new(params[:post])
    unless @post.user == user_def
      flash[:notice] = 'You are not authorized to Create the Post.'
      flash[:color] = 'invalid'
      redirect_to login_path
    end
    if @post.save
      redirect_to @post, :notice => "#{@post.title}, is successfully created."
      flash[:notice]
    else
      render 'new'
    end
  end

  def update  
    @post = user_def.posts.find(params[:id])
    unless @post.user == user_def
      flash[:notice] = 'You are not authorized to Update this Post.'
      flash[:color] = 'invalid'
      redirect_to login_path
    end
    if @post.update_attributes(params[:post])
        redirect_to @post, :notice => "#{@post.title}, is successfully updated." 
        flash[:notice]
    else
      render 'edit'
    end
  end

  def destroy
    @post = user_def.posts.find(params[:id])
    unless @post.user == user_def
      flash[:notice] = 'You are not authorized to Delete the Post.'
      flash[:color] = "invalid"
      redirect_to login_path    
		end
      redirect_to posts_path, :notice=> "#{@post.title}, is successfully deleted."
      flash[:notice]	  
			@post.destroy    
  end
end