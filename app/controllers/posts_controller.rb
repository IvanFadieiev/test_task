class PostsController < ApplicationController
  # posts_controller
  before_filter :find_post, only: [:destroy, :edit, :update]
  before_filter :find_user, only: [:new, :avatar, :create]
  respond_to :html, :js
  def create
    @post = @user.posts.create(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
      @posts = Post.all
  end

  def new
    @post = @user.posts.build
  end

  def show
    begin
      @post = Post.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        logger.error "Post #{params[:id]} not found"
        redirect_to posts_path
      else
        @user = @post.user
        @avatar = @user.avatar
      end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def my_posts
    @post = current_user.posts
  end

  def avatar
    @avatar = @user.avatar
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end

