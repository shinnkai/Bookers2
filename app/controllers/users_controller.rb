class UsersController < ApplicationController

 before_action :check_user, only: [:edit]

 def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book.id)
  else
    @books = Book.all
    @user = current_user
    render:index
  end
 end

 def index
    @users = User.all
    @book = Book.new
    @user = current_user
 end

 def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
 end

 def edit
    @user = User.find(params[:id])
 end

 def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render:edit
    end
 end

 private

 def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)

 end

 def check_user
  @user = User.find(params[:id])
  if @user.id != current_user.id
    redirect_to user_path(current_user)
  end
 end



end
