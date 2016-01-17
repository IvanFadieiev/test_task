# SessionsController
class SessionsController < ApplicationController
  def new
    signed_in
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      flash[:success] = "Добро пожаловать на сайт!"
    else
      flash.now[:error] = 'Не верная комбинация email/password!'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to :root
    flash[:success] = "Всего хорошего!"
  end
  
  private

  def signed_in
    if signed_in?
      @user = current_user
      redirect_to user_path(@user)
    end
  end
end
