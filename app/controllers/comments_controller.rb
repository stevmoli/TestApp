class CommentsController < ApplicationController
  before_filter :get_comment, :only => [:edit, :update, :destroy]
  before_filter :check_authentication, :only => [:edit, :update, :destroy]

  def get_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def check_authentication
    if session[:user_id] != @comment.user_id
      flash[:notice] = "You can't edit other users' comments."
      redirect_to :back   # this causes the page to reload with the flash message instead of taking you to the edit page
    end
  end

  def index # don't need a comment index page; comments will all appear with their associated posts
  end

  def show
  	@comment = Comment.find(params[:id])
  end

  def new

  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def create
  	post = Post.find(params[:post_id])
  	# ap comment_params
    # @comment = post.comments.create(comment_params)
    @comment = post.comments.build(comment_params).tap do |c|
      c.user = current_user
      c.save
    end

    redirect_to post
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(comment_params)
      redirect_to @post
    else
      render edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment_id = @comment.id
    @comment.destroy
    #redirect_to @post
    respond_to do |format|
      format.html {redirect_to @post}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end


end
