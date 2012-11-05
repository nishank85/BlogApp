class CommentsController < ApplicationController

  def index
    @commentable = find_commentable
    @comments = @commentable.comments 
  end

  def show
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
  end

  def new
    @commentable = find_commentable
    @comment = @commentable.comments.new
  end

  def edit
    flash[:notice] = 'Sorry ! You dont have access to this page !!!'
    flash[:color] = 'invalid'
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = 'Comment is successfully created.'
      redirect_to post_comment_path(@commentable, @comment)
    else
      render 'new'
    end
  end

  def update
    flash[:notice] = 'Sorry ! You dont have access to this page !!!'
    flash[:color] = 'invalid'
  end

  def destroy
    @commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
    unless @commentable.user == user_def
      flash[:notice] = 'Sorry ! You dont have access to this page !!!'
      flash[:color] = 'invalid'
      redirect_to login_path
    end
    @comment.destroy
    flash[:notice] = 'Comment is successfully deleted.'
    redirect_to post_path(@commentable)
   end

private
   def find_commentable
    params.each do |key,value|
      if key =~/(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end