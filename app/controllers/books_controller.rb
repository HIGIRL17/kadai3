class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only:[:edit,:update,:destroy]}

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      render :index
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id)
       flash[:notice] = "You have updated book successfully."
    else
       render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def ensure_correct_user
    @book = Book.find(params[:id])

  if @book.user_id != current_user.id
    redirect_to books_path
  end

  end

  def book_params
    params.require(:book).permit(:title, :body,)
  end

end
