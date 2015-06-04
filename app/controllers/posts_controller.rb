class PostsController < ApplicationController
  before_filter :get_post, :only => [:edit, :update, :destroy]
  before_filter :check_authentication, :only => [:edit, :update, :destroy]

  def get_post
    @post = Post.find(params[:id])
  end

  def check_authentication
    if session[:user_id] != @post.user_id
      flash[:notice] = "You can't edit other users' posts."
      redirect_to :back   # this causes the page to reload with the flash message instead of taking you to the edit page
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.create(post_params)
    redirect_to @post
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
