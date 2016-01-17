# posts_controller
class PostsController < ApplicationController
  before_filter :find_post, only: [:destroy, :edit, :update]
  before_filter :find_user, only: [:new, :avatar, :create]
  respond_to :html, :json, :js
  def create
    @post = @user.posts.create(post_params)
    if @post.save
      redirect_to posts_path
      flash[:success] = "Обьявление удачно добавлено!"
    else
      render 'new'
    end
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = @user.posts.build
  end

  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    logger.error "Обьявление #{params[:id]} не найдено!"
    redirect_to posts_path
  else
    @user = @post.user
    @avatar = @user.avatar
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
      format.js { render layout: false }
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:success] = "Обьявление обновлено!"
    else
      render 'edit'
    end
  end

  def my_posts
    @post = current_user.posts.paginate(page: params[:page], per_page: 5)
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
