# comments_controller
class CommentsController < ApplicationController
  before_filter :get_parent, only: [:new, :create, :edit, :update]
  before_filter :find_comment, only: [:edit, :update, :destroy]
  respond_to :html,:json, :js
  def new
    @comment = @parent.comments.build
    @comment.user_id = current_user.id
    respond_to do |format|
      format.html
      format.js 
      format.json
    end
  end

  def create
    @comment = @parent.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
      format.html { 
        redirect }
      format.json { render action: 'show', status: :created, location: @comment }
      format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js   { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @comment.update(comment_params)
      redirect
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url}
      format.json { head :no_content }
      format.js { render :layout => false }
   end 
  end

  protected
   
  def get_parent
    @parent = Post.find_by_id(params[:post_id]) if params[:post_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id] 
    # redirect_to root_path unless defined?(@parent)
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body, :commentable_id, :commentable_type)    
  end

  def redirect
    loop do
    if @comment.commentable_type == "Post" then
       redirect_to post_path(@comment.commentable_id)
       flash[:success] = "Комментарий удачно добавлен!"
    break
    end
      @id = @comment.commentable_id
      @comment = Comment.find_by_id(@id)
    end
  end
end
