class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 9)

  end


  def show
    @posts = @user.posts.paginate(page: params[:page], per_page: 3)
  end


  def new
    @user = User.new
  end


  def edit
  end


   def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Добро пожаловать на сайт обьявлений!"
      redirect_to @user
    else
      render 'new'
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy
    redirect_to :root
    flash[:success] = "Пользователь удален!"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    
    def user_params
      params.require(:user).permit(:name, :email,
      :password, :password_confirmation, :avatar)
    end
end
