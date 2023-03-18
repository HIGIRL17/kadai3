class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user ,{only:[:edit,:update]}


  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
    flash[:notice] = "You have created book successfully."
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to edit_user_path(current_user.id)
    end

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def ensure_correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end