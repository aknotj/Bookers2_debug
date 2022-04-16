class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :following, :followers]

  def show
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      current_user.entries.each do |cu|
        @user.entries.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
    @books = @user.books
    @book = Book.new

    @books_today = @user.books.created_today
    @books_yesterday = @user.books.created_yesterday
    if @books_yesterday.count == 0
      @daily_growth = @books_today.count*100
    else
      @from_yesterday = @books_today.count/@books_yesterday.count
      @daily_growth = (@from_yesterday.to_f*100).round == 0
    end

    @books_this_week = @user.books.created_this_week
    @books_last_week = @user.books.created_last_week
    if @books_last_week.count == 0
      @weekly_growth = @books_this_week.count*100
    else
      @from_last_week = @books_this_week.count/@books_last_week.count
      @weekly_growth = (@from_last_week.to_f*100).round == 0
    end

    @books_2days_ago = @books.created_two_days_ago
    @books_3days_ago = @books.created_three_days_ago
    @books_4days_ago = @books.created_four_days_ago
    @books_5days_ago = @books.created_five_days_ago
    @books_6days_ago = @books.created_six_days_ago

  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @obj = @user
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @obj = @user
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を選択してください"
    else
      create_at = params[:created_at]
      @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
