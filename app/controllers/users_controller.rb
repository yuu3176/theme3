class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully updated!!"
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
